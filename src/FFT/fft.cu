#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include <cufft.h>

#define SIGNAL_SIZE 512

////////////////////////////////////////////////////////////////////////////////
// Program main
////////////////////////////////////////////////////////////////////////////////
int main(int argc, char** argv)
{
    cuComplex* h_signal = nullptr;
    cuComplex* d_signal = nullptr;
    const size_t memSize = sizeof(cuComplex) * SIGNAL_SIZE;

    h_signal = (cuComplex*)malloc(memSize);
    for (unsigned int i = 0; i < SIGNAL_SIZE; ++i) {
        h_signal[i].x = static_cast<float>(rand());
        h_signal[i].y = 0;
    }

    cudaMalloc((void**)&d_signal, memSize);

    // Copy host memory to device
    cudaMemcpy(d_signal, h_signal, memSize, cudaMemcpyHostToDevice);

    cufftHandle plan;
    cufftPlan1d(&plan, SIGNAL_SIZE, CUFFT_C2C, 1);

    cufftExecC2C(plan, (cufftComplex *)d_signal, (cufftComplex *)d_signal, CUFFT_FORWARD);

    // Copy device memory to host
    cudaMemcpy(h_signal, d_signal, memSize, cudaMemcpyDeviceToHost);

    // Destroy CUFFT context
    cufftDestroy(plan);

    // cleanup memory
    free(h_signal);
    cudaFree(d_signal);
}
