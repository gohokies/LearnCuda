cmake_minimum_required(VERSION 3.10)

project(LearnCuda LANGUAGES C CXX CUDA)

cmake_policy(SET CMP0104 NEW)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  set(CMAKE_CUDA_ARCHITECTURES native)
endif()

add_subdirectory(src)

