cmake_minimum_required(VERSION 3.16)
project(ode LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

file(GLOB_RECURSE SOURCES
    src/*.cpp
    include/*.hpp
)

add_executable(ode ${SOURCES})

target_include_directories(ode PRIVATE
    ${CMAKE_SOURCE_DIR}/include
)
