
add_executable(VectorAdd VectorAdd.cu)
set_target_properties(VectorAdd PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
