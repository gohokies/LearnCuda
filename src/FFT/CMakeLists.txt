
cuda_add_executable(FFTDemo fft.cu)
cuda_add_cufft_to_target(FFTDemo)
