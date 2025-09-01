cmake_minimum_required(VERSION 4.1.0)
project(MyCompiler LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

file(GLOB SOURCES src/*.cpp)

add_executable(my-compiler ${SOURCES})

