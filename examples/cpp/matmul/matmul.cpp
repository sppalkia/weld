#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include <immintrin.h>

#include <sys/time.h>
#include <string.h>

#include "mkl_cblas.h"

#define RUNS 3

const int64_t DIM = 8192;
const int64_t BLOCK = 512;

// Include the Weld API.
#include "../../../c/weld.h"

struct weld_vector {
  float *data;
  int64_t length;
};

struct args {
  weld_vector A;
  weld_vector B;
  weld_vector C;
  int64_t DIM;
  int64_t BLOCK;
};

const char *blas_program = "\
                |matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                cudf[do_matmul_mkl_wrapper,vec[f32]](matrix_a, matrix_b, matrix_out, DIM, BLOCK)";

// Blocked SIMD with Iterate
#if 1
const char *program = "\
                       |matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                       result(for (rangeiter(0L, DIM, BLOCK), vecmerger[f32,+](matrix_out), |b,_,i|\
                             for (rangeiter(0L, DIM, BLOCK), b, |b,_,j|\
                               for (rangeiter(0L, DIM, BLOCK), b, |b,_,k|\
                                 for (rangeiter(i, i+BLOCK, 1L), b, |b,_,ii|\
                                   for (rangeiter(j, j+BLOCK, 1L), b, |b,_,jj|\
                                     merge(b,\
                                       { jj + ii * DIM,\
                                       simdreduce(iterate({k, broadcast(0.0f)}, |e:{i64, simd[f32]}|\
                                             let kk = e.$0;\
                                             if(kk >= k + BLOCK,\
                                               {e, false},\
                                               {\
                                               {\
                                               kk + 128L,\
                                               let base_ii = ii * DIM + kk;\
                                               let base_jj = jj * DIM + kk;\
                                               let a = simdlookup(matrix_a, base_ii) * simdlookup(matrix_b, base_jj)\
                                               + simdlookup(matrix_a, base_ii + 8L) * simdlookup(matrix_b, base_jj + 8L);\
                                               let b = simdlookup(matrix_a, base_ii + 16L) * simdlookup(matrix_b, base_jj + 16L)\
                                               + simdlookup(matrix_a, base_ii + 24L) * simdlookup(matrix_b, base_jj + 24L);\
                                               let c = simdlookup(matrix_a, base_ii + 32L) * simdlookup(matrix_b, base_jj + 32L)\
                                               + simdlookup(matrix_a, base_ii + 40L) * simdlookup(matrix_b, base_jj + 40L);\
                                               let d = simdlookup(matrix_a, base_ii + 48L) * simdlookup(matrix_b, base_jj + 48L)\
                                               + simdlookup(matrix_a, base_ii + 56L) * simdlookup(matrix_b, base_jj + 56L);\
                                               let f = simdlookup(matrix_a, base_ii + 64L) * simdlookup(matrix_b, base_jj + 64L)\
                                               + simdlookup(matrix_a, base_ii + 72L) * simdlookup(matrix_b, base_jj + 72L);\
                                               let g = simdlookup(matrix_a, base_ii + 80L) * simdlookup(matrix_b, base_jj + 80L)\
                                               + simdlookup(matrix_a, base_ii + 88L) * simdlookup(matrix_b, base_jj + 88L);\
                                               let h = simdlookup(matrix_a, base_ii + 96L) * simdlookup(matrix_b, base_jj + 96L)\
                                               + simdlookup(matrix_a, base_ii + 104L) * simdlookup(matrix_b, base_jj + 104L);\
                                               let m = simdlookup(matrix_a, base_ii + 112L) * simdlookup(matrix_b, base_jj + 112L)\
                                               + simdlookup(matrix_a, base_ii + 120L) * simdlookup(matrix_b, base_jj + 120L);\
                                               e.$1 + a + b + c + d + f + g + h + m\
                                               },\
                                               true\
                                               })\
                                             ).$1,+)\
                                       }\
                                       )\
                                     ))))))";
#endif

// Blocked SIMD with Nested Iterate
#if 0

const char *program = "|matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                       result(\
                           for(rangeiter(0L, DIM, BLOCK), vecmerger[f32,+](matrix_out), |b,_,i|\
                             for (rangeiter(0L, DIM, BLOCK), b, |b,_,j|\
                               for (rangeiter(0L, DIM, BLOCK), b, |b,_,k|\
                                 for (rangeiter(i, i+BLOCK, 1L), b, |b,_,ii|\
                                   iterate({j, b}, |e: {i64, vecmerger[f32,+]}|\
                                     let jj = e.$0;\
                                     if( jj >= j + BLOCK,\
                                       {e, false},\
                                       {{jj + 1L, merge(b,\
                                           { jj + ii * DIM,\
                                           simdreduce(iterate({k, broadcast(0.0f)}, |e:{i64, simd[f32]}|\
                                                 let kk = e.$0;\
                                                 if(kk >= k + BLOCK,\
                                                   {e, false},\
                                                   {\
                                                   {\
                                                   kk + 8L,\
                                                   e.$1 + simdlookup(matrix_a, ii * DIM + kk) * simdlookup(matrix_b, jj * DIM + kk)\
                                                   },\
                                                   true\
                                                   })\
                                                 ).$1,+)\
                                           }\
                                           )\
                                       }, true}\
                                       )\
                                     ).$1\
                                     )))))";

#endif

// Unblocked Naive
#if 0
const char *program = "|matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                       result(\
                           for(rangeiter(0L, DIM, 1L), vecmerger[f32,+](matrix_out), |b,_,i|\
                             for (rangeiter(0L, DIM, 1L), b, |b,_,j|\
                                merge(b, {j + i * DIM, iterate({0L, 0.0f}, |e:{i64,f32}|\
                                  let k = e.$0;\
                                  if(k >= DIM,\
                                    {e, false},\
                                    {{k + 1L, e.$1 + lookup(matrix_a, k + i * DIM) * lookup(matrix_b, j + k * DIM)}, true}\
                                  )).$1})\
                              )))";
#endif

// Blocked scalar
#if 0
const char *program = "\
                       |matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                       result(for(rangeiter(0L, DIM, BLOCK), vecmerger[f32,+](matrix_out), |b,_,i|\
                             for (rangeiter(0L, DIM, BLOCK), b, |b,_,j|\
                               for (rangeiter(0L, DIM, BLOCK), b, |b,_,k|\
                                 for (rangeiter(i, i+BLOCK, 1L), b, |b,_,ii|\
                                   for (rangeiter(j, j+BLOCK, 1L), b, |b,_,jj|\
                                     for(rangeiter(k, k+BLOCK, 1L), b, |b,_,kk|\
                                       merge(b, {jj + ii * DIM, lookup(matrix_a, ii * DIM + kk) * lookup(matrix_b, jj * DIM + kk)})\
                                       )))))))";
#endif

// Blocked SIMD with For loop
#if 0
const char *program = "\
                       |matrix_a: vec[f32], matrix_b: vec[f32], matrix_out: vec[f32],  DIM: i64, BLOCK: i64|\
                       result(for (rangeiter(0L, DIM, BLOCK), vecmerger[f32,+](matrix_out), |b,_,i|\
                             for (rangeiter(0L, DIM, BLOCK), b, |b,_,j|\
                               for (rangeiter(0L, DIM, BLOCK), b, |b,_,k|\
                                 for (rangeiter(i, i+BLOCK, 1L), b, |b,_,ii|\
                                   for (rangeiter(j, j+BLOCK, 1L), b, |b,_,jj|\
                                     merge(b, {\
                                       jj + ii * DIM,\
                                       result(for(\
                                             rangeiter(k, k+BLOCK, 8L), merger[f32,+], |b2,_,kk|\
                                             merge(b2, simdlookup(matrix_a, ii * DIM + kk) * simdlookup(matrix_b, jj * DIM + kk)\
                                               )\
                                             ))\
                                       }\
                                       )))))))";
#endif

// This is a naive C loop that is optimized by LLVM's Polly infrastructure.
void do_matmul(float *A, float *B, float *C, const size_t DIM, const size_t _) {
  for (size_t i = 0; i < DIM; i++) {
    for (size_t j = 0; j < DIM; j++ ) {
      for (size_t k = 0; k < DIM; k++) {
        C[j + i * DIM] += A[k + i * DIM] * B[k + j * DIM];
      }
    }
  }
}

#define VECSIZE 8
void do_matmul_well(float *A, float *B, float *C, const size_t DIM, const size_t BLOCK) {
  for (size_t i = 0; i < DIM; i+=BLOCK) {
    for (size_t j = 0; j < DIM; j+=BLOCK ) {
      for (size_t k = 0; k < DIM; k+=BLOCK) {
        for (size_t ii = i; ii < i + BLOCK; ii++) {
          for (size_t jj = j; jj < j + BLOCK; jj++) {
            __m256 c = _mm256_setzero_ps();
            float c_buf[VECSIZE];
            for (size_t kk = k; kk < k + BLOCK; kk+=VECSIZE) {
              __m256d a, b;
              a = _mm256_loadu_ps(&A[ii * DIM + kk]);
              b = _mm256_loadu_ps(&B[jj * DIM + kk]);
              c = _mm256_add_ps(c, _mm256_mul_ps(a, b));
            }
            _mm256_storeu_ps(c_buf, c);
            for (size_t v = 0; v < VECSIZE; v++) {
              C[jj + ii * DIM] += c_buf[v];
            }
          }
        }
      }
    }
  }
}

void do_matmul_mkl(float *A, float *B, float *C, const size_t DIM, const size_t _2) {
  const float alpha = 1.0;
  const float beta = 0.0;
  cblas_sgemm(CblasColMajor,
      CblasTrans,
      CblasNoTrans,
      DIM,
      DIM,
      DIM,
      alpha,
      A, DIM, B, DIM, beta, C, DIM);
}


extern "C" void do_matmul_mkl_wrapper(weld_vector *A,
    weld_vector *B,
    weld_vector *C,
    int64_t *DIM,
    int64_t *BLOCK,
    weld_vector *result) {

  do_matmul_mkl(A->data, B->data, C->data, *DIM, *BLOCK);
  *result = *C;
}

int main() {
  // Compile Weld module.
  weld_error_t e = weld_error_new();
  weld_conf_t conf = weld_conf_new();

  weld_conf_set(conf, "weld.compile.multithreadSupport", "false");
  weld_conf_set(conf, "weld.llvm.optimization.level", "3");

  weld_module_t m = weld_module_compile(program, conf, e);
  weld_conf_free(conf);

  if (weld_error_code(e)) {
    const char *err = weld_error_message(e);
    printf("Error message: %s\n", err);
    exit(1);
  }

  weld_vector A, B, C;

  float *data_a = (float *)malloc(sizeof(float) * DIM * DIM);
  float *data_b = (float *)malloc(sizeof(float) * DIM * DIM);
  float *data_c = (float *)malloc(sizeof(float) * DIM * DIM);

  memset(data_c, 0, sizeof(float) * DIM * DIM);

  for (int i = 0; i < DIM * DIM; i++) {
    data_a[i] = i % 10;
    data_b[i] = i % 10;
  }

  A.data = data_a;
  A.length = DIM * DIM;

  B.data = data_b;
  B.length = DIM * DIM;

  // This is the vecmerger's initial argument.
  C.data = data_c;
  C.length = DIM * DIM;

  struct args arg;
  arg.A = A;
  arg.B = B;
  arg.C = C;
  arg.DIM = DIM;
  arg.BLOCK = BLOCK;

  weld_value_t warg = weld_value_new(&arg);

  struct timeval start, end, diff;

  ///////////////////////////////////////////////
  //
  // Naive Matmul
  // 
  ///////////////////////////////////////////////

#if 1


  for (int i = 0 ; i < RUNS; i++) {

    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("Naive Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

    memset(C.data, 0, sizeof(float) * DIM * DIM);

  }

#endif

#if 0
  ///////////////////////////////////////////////
  //
  // MKL
  // 
  ///////////////////////////////////////////////

  for (int i = 0 ; i < RUNS; i++) {

    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul_mkl(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("MKL Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

    memset(C.data, 0, sizeof(float) * DIM * DIM);

  }

#endif

#if 0
  ///////////////////////////////////////////////
  //
  // Blocked and Vectorized Matmul
  // 
  ///////////////////////////////////////////////


  for (int i = 0 ; i < RUNS; i++) {

    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul_well(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("Hand Blocked + Vectorized Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

    memset(C.data, 0, sizeof(float) * DIM * DIM);

  }
#endif

#if 0

  ///////////////////////////////////////////////
  //
  // Weld
  // 
  ///////////////////////////////////////////////

  conf = weld_conf_new();

  for (int i = 0 ; i < RUNS; i++) {

    gettimeofday(&start, NULL);
    // Run the module and get the result.
    weld_value_t result = weld_module_run(m, conf, warg, e);
    if (weld_error_code(e)) {
      const char *err = weld_error_message(e);
      printf("Error message: %s\n", err);
      exit(1);
    }
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    weld_vector *result_data = (weld_vector *)weld_value_data(result);
    printf("Weld Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), result_data->data[0]);
    weld_value_free(result);
  }

#endif

#if 0

  ///////////////////////////////////////////////
  //
  // Weld MKL
  // 
  ///////////////////////////////////////////////
  
  e = weld_error_new();
  conf = weld_conf_new();

  weld_conf_set(conf, "weld.compile.multithreadSupport", "false");
  weld_conf_set(conf, "weld.llvm.optimization.level", "3");

  m = weld_module_compile(blas_program, conf, e);
  weld_conf_free(conf);

  if (weld_error_code(e)) {
    const char *err = weld_error_message(e);
    printf("Error message: %s\n", err);
    exit(1);
  }

  conf = weld_conf_new();

  for (int i = 0 ; i < RUNS; i++) {

    gettimeofday(&start, NULL);
    // Run the module and get the result.
    weld_value_t result = weld_module_run(m, conf, warg, e);
    if (weld_error_code(e)) {
      const char *err = weld_error_message(e);
      printf("Error message: %s\n", err);
      exit(1);
    }
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    weld_vector *result_data = (weld_vector *)weld_value_data(result);
    printf("Weld BLAS Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), result_data->data[0]);
    weld_value_free(result);
  }

#endif

  // Free allocated data.
  free(data_a);
  free(data_b);
  free(data_c);

  // Free the values.
  //weld_value_free(warg);
  //weld_conf_free(conf);

  weld_error_free(e);
  weld_module_free(m);
  return 0;
}
