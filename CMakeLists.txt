cmake_minimum_required(VERSION 3.16)
project(ode LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ---------------------------------------------
# 1. Collect your source files
# ---------------------------------------------
file(GLOB_RECURSE SOURCES
    src/*.cpp
    include/*.hpp
)

add_executable(ode ${SOURCES})

target_include_directories(ode PRIVATE
    ${CMAKE_SOURCE_DIR}/include
)

# ---------------------------------------------
# 2. Find LLVM (using llvm-config)
# ---------------------------------------------
find_program(LLVM_CONFIG_EXECUTABLE NAMES llvm-config REQUIRED)

# Get include and lib paths from llvm-config
execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} --libdir
    OUTPUT_VARIABLE LLVM_LIB_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} --libs core
    OUTPUT_VARIABLE LLVM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} --system-libs
    OUTPUT_VARIABLE LLVM_SYSTEM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE)

# ---------------------------------------------
# 3. Apply LLVM configuration to your target
# ---------------------------------------------
target_include_directories(ode PRIVATE ${LLVM_INCLUDE_DIR})
target_link_directories(ode PRIVATE ${LLVM_LIB_DIR})

# Split libs into a CMake list (space separated)
separate_arguments(LLVM_LIBS)
separate_arguments(LLVM_SYSTEM_LIBS)

target_link_libraries(ode PRIVATE ${LLVM_LIBS} ${LLVM_SYSTEM_LIBS})

# ---------------------------------------------
# 4. Ensure rpath so it runs without DYLD tweaks
# ---------------------------------------------
set_target_properties(ode PROPERTIES
    BUILD_RPATH "${LLVM_LIB_DIR}"
)
