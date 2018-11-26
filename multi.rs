//! Multi-threaded runtime design for Weld using Rust threads.
//!
//! The proposal is to implement fixed task-size OpenMP style parallelism using Rust threads.
//!
//! Weld would generate loops that span three functions, similar to what we had before. For a loop
//! function `f1`, we would have:
//!
//! `f1_parallel`, which sets up and invokes the parallel work and returns an updated builder,
//! `f1_loop`, which implements the sequential loop code and updates a builder on a thread, and
//! `f1_wrapper`, which is an opaque wrapper passed to the threading library.
//!
//! Currently, loops are functions that return a builder. For example, in sequential code, if we
//! have:
//!
//! ```weld
//! let x = merger[i32,+];
//! let b = for(vector, x, ...);
//! result(b)
//! ```
//!
//! The loop would be invoked as follows (pseudo-LLVM):
//!
//! ```llvm
//! %0 = load %merger, %merger* %builder
//! %1 = call %merger f1_loop(%0, /* other args */)
//! store %merger* %1, %builder
//! ```
//!
//! Similarly, in the new parallel model, we would have:
//! ```llvm
//! %0 = load %merger, %merger* %builder
//! // Similar to sequential version.
//! %1 = call %merger f1_parallel(%0, /* other args */)
//! store %merger* %1, %builder
//! ```
//!
//! # Parallelizing Builders
//!
//! Builders would be parallelized by "splitting" them into thread local copies, passing those
//! copies to each thread, updating them locally, and them combining them. For builders that
//! interally use locks, the splitting phase can just copy the builder and its pointers. For
//! builders that want true local copies (e.g., `merger`), the builder is deep-copied.
//!
//! The `f1_parallel` function takes an input builder and copies it into `NUM_THREADS` copies using
//! a builder-specific `clone` function. Each copy is stored into a pointer. The function then
//! shallow copies the remaining arguments and wraps the builder pointer and the arguments into a struct.
//!
//! The struct is passed, along with a function pointer to the `f1_wrapper` function, to
//! `weld_rt_parallel`, which invokes parallel work. This function simply spawns `NUM_THREADS` Rust
//! threads and invokes the `f1_wrapper(arg[thread_id])` on each thread. The function then waits
//! until all threads finish executing.
//!
//! The `f1_wrapper` function (typedef'd below as `WeldFn`) takes an opaque struct holding the
//! thread-local arguments, the run handle, and the thread ID. The arguments are unwrapped and
//! passed into `f1_loop`, which executes the sequential loop as always. This sequential loop
//! returns the updated builder; this builder is then stored in the builder pointer passed in the
//! argument struct to `f1_wrapper`.
//!
//! Once all threads finish executing, `weld_rt_parallel` returns back into `f1_parallel`. The
//! builder copies are updated (since `f1_wrapper` writes its builder result into the builder
//! pointer it receives). A builder-specific `combine` function merges these partial builders into
//! a single one, which is stored into the result of the loop.
//!
//!
//! The file below illustrates some pseudo-Rust code that implements this system, with some tedium
//! omitted.

/// The wrapper function passed from generated LLVM to Rust.
///
/// The arguments are the argument struct, the run handle, and the thread ID.
///
/// This function does not return anything: the returned builder is stored in the pointer contained
/// in the argument struct.
type WeldFn = fn(*mut c_void, RunHandleRef, thread_id: i32);

/// Invokes parallel work for a Weld loop.
///
/// `function` is the function to invoke. `arguments` is a list of arguments wrapped in a struct,
/// one per thread. `run` is the run handle.
fn weld_rt_parallel(function: WeldFn, arguments: *mut c_void, run: RunHandleRef) {
    let mut threads = vec![];
    for i in 0...workers {
        threads.push(thread::spawn(move || {
            // Updates the builder.
            function(arguments[i], run, i as i32);
        }));
    }

    // The main thread blocks until the workers finish. The workers thus cannot outlive the parent
    // and may access data in the parents' stack.
    for thread in threads {
        thread.join();
    }
}

/// 1. Prepare builder for parallel work (e.g., clone a merger)
/// 2. Package arguments.
/// 3. Call parallel()
/// 4. Merge builders into single value ("collapse").
///
///
/// This function is generated in LLVM.
fn f1_parallel(/* closure arguments */) {
    
    // builders is list of builder pointers, with the pointers pointing to cloned copies of the
    // input. This needs to be done for all builders passed as arguments to the function.
    //
    // For example, if the input is a merger[i32,+] (represented as a single i32), we would do:
    //
    // builders = malloc(sizeof(i32) * n_workers)
    // builders[0] = merger.clone(initial) // just copies the i32
    // builders[1] = merger.clone(initial) // just copies the i32
    // ...
    // builders[n_workers - 1] = merger.clone(initial) // just copies the i32
    //
    // The clone() impl would depend on the builder type:
    //      For merger: Clones the value
    //      For appender: Allocates a new contiguous buffer
    //      For dictionaries: Internally locked, just copy the pointer.
    let builders = vec![builder.clone(); n_workers]; 

    // Assemble struct containing the arguments.
    let arguments = builders.enumerate().map(|i, b| {
        // Packages arguments into a struct.
        Struct {
            // Stores pointer to the builder.
            builder: builders + i,
            // Other args
        }
    }).collect();

    // Updates the builder pointers.
    weld_rt_parallel(f1_wrapper, arguments);

    for builder in builders {
        // Input is the input builder that was passed to f1_parallel. Again, this step will happen
        // once per builder passed in.
        //
        // Combine merges the partial results into the input builder to update it. Examples:
        //
        // For merger, combines the partial sums by doing input + builders[0] + builders[1] ...
        // For dicts, does nothing since all builders point to same underlying structure.
        // For appender:
        //      new_size = input.size + sum(builders[0].size + builders[1].size + ...)
        //      input.pointer = realloc(input.pointer, new_size)
        //
        //      offset = input.size
        //      for builder in builders {
        //         memcpy(input.pointer + offset, builder.pointer, builder.size)  
        //         offset += builder.size
        //      }
        //      input.size = new_size
        input.combine(builder)
    }

    // Store the updated input the output.
    store(input, output);
}

/// The `WeldFn` that is code-generated in LLVM.
fn f1_wrapper(arguments: *mut c_void, run: RunHandleRef, thread: i32) {
    // Unwrap into individual values.
    //
    // The builder_pointer points into the builders array created in `f1_parallel`.
    let (builder_pointer, other_args) = unwrap(arguments);

    // The sequential loopin function takes a builder (not builder pointer) as an argument, so the
    // builder is always stack allocated.
    builder = load(builder_pointer);

    // This is the sequential looping code.
    //
    // result is the locally updated builder.
    result = f1_loop(builder, **args, run);

    // Write the updated builder into the pointer. False sharing here, but only O(n_workers)
    // writes, so doesn't really matter...
    *builder_pointer = result;
}
