#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include <immintrin.h>

#include <sys/time.h>
#include <string.h>

#include "mkl_cblas.h"

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
        if(e.$0 >= k + BLOCK,\
          {e, false},\
          {\
            let kk = e.$0;\
            {\
              kk + 8L,\
              e.$1 + simdlookup(matrix_a, ii * DIM + kk) * simdlookup(matrix_b, jj * DIM + kk)\
            },\
            true\
          })\
      ).$1,+)\
    }\
  )\
))))))";
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
        C[j + i * DIM] += A[k + i * DIM] * B[j + k * DIM];
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
      CblasNoTrans,
      CblasNoTrans,
      DIM,
      DIM,
      DIM,
      alpha,
      A, DIM, B, DIM, beta, C, DIM);
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

    const int64_t DIM = 2048;
    const int64_t BLOCK = 512;
    weld_vector A, B, C;

    float *data_a = (float *)malloc(sizeof(float) * DIM * DIM);
    float *data_b = (float *)malloc(sizeof(float) * DIM * DIM);
    float *data_c = (float *)malloc(sizeof(float) * DIM * DIM);

    memset(data_c, 0, sizeof(float) * DIM * DIM);

    for (int i = 0; i < DIM * DIM; i++) {
        data_a[i] = 1;
        data_b[i] = 1;
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
    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("Polly Optimized Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

#endif

    ///////////////////////////////////////////////
    //
    // MKL
    // 
    ///////////////////////////////////////////////

    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul_mkl(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("MKL Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

    memset(C.data, 0, sizeof(float) * DIM * DIM);

    ///////////////////////////////////////////////
    //
    // Blocked and Vectorized Matmul
    // 
    ///////////////////////////////////////////////

    // Time the C version.
    gettimeofday(&start, NULL);
    do_matmul_well(A.data, B.data, C.data, DIM, BLOCK);
    gettimeofday(&end, NULL);
    timersub(&end, &start, &diff);
    printf("Hand Blocked + Vectorized Loop: %f seconds (first elem=%f)\n",
        (float)diff.tv_sec + ((float)diff.tv_usec / 1000000.0), C.data[0]);

    memset(C.data, 0, sizeof(float) * DIM * DIM);

    ///////////////////////////////////////////////
    //
    // Weld
    // 
    ///////////////////////////////////////////////

    gettimeofday(&start, NULL);
    // Run the module and get the result.
    conf = weld_conf_new();
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

    // Free allocated data.
    free(data_a);
    free(data_b);
    free(data_c);

    // Free the values.
    weld_value_free(result);
    weld_value_free(warg);
    weld_conf_free(conf);

    weld_error_free(e);
    weld_module_free(m);
    return 0;
}
