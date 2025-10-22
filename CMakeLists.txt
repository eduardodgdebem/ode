cmake_minimum_required(VERSION 3.16)
project(ode LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Add optimization flags for macOS with LLVM
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

# Find LLVM
find_program(LLVM_CONFIG_EXECUTABLE NAMES llvm-config REQUIRED)

# Get LLVM configuration
execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --libdir
    OUTPUT_VARIABLE LLVM_LIB_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --cxxflags
    OUTPUT_VARIABLE LLVM_CXX_FLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Request all components needed for code generation
execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --libs core native support mc option object
    OUTPUT_VARIABLE LLVM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --system-libs
    OUTPUT_VARIABLE LLVM_SYSTEM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Get version info
execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --version
    OUTPUT_VARIABLE LLVM_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "LLVM Version: ${LLVM_VERSION}")
message(STATUS "LLVM Include Dir: ${LLVM_INCLUDE_DIR}")
message(STATUS "LLVM Lib Dir: ${LLVM_LIB_DIR}")

# Collect source files
file(GLOB_RECURSE SOURCES src/*.cpp)

# Create executable
add_executable(ode ${SOURCES})

# Apply LLVM configuration
target_include_directories(ode PRIVATE
    ${CMAKE_SOURCE_DIR}/include
    ${LLVM_INCLUDE_DIR}
)

target_link_directories(ode PRIVATE ${LLVM_LIB_DIR})

# Parse LLVM flags
separate_arguments(LLVM_LIBS)
separate_arguments(LLVM_SYSTEM_LIBS)

target_link_libraries(ode PRIVATE 
    ${LLVM_LIBS}
    ${LLVM_SYSTEM_LIBS}
)

# Set rpath for macOS
set_target_properties(ode PROPERTIES
    BUILD_RPATH "${LLVM_LIB_DIR}"
    INSTALL_RPATH "${LLVM_LIB_DIR}"
)
