cmake_minimum_required(VERSION 3.20)
project(eureka_optimizer CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

if(DEFINED ENV{LLVM_SYS_181_PREFIX})
    list(APPEND CMAKE_PREFIX_PATH "$ENV{LLVM_SYS_181_PREFIX}")
endif()

find_package(LLVM REQUIRED CONFIG)

if(LLVM_PACKAGE_VERSION VERSION_LESS "18.0" OR
   LLVM_PACKAGE_VERSION VERSION_GREATER_EQUAL "19.0")
    message(FATAL_ERROR "LLVM 18.x required, found ${LLVM_PACKAGE_VERSION}")
endif()

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")

find_package(VTune QUIET)
if(VTUNE_FOUND AND LLVM_USE_INTEL_JITEVENTS)
    list(APPEND LLVM_OPTIONAL_COMPONENTS IntelJITEvents)
endif()

llvm_map_components_to_libnames(LLVM_LIBS
    analysis core executionengine orcjit
    passes profiledata support target native
    ${LLVM_OPTIONAL_COMPONENTS}
)

add_library(tti STATIC cpp/tti_wrapper.cpp)

set_target_properties(tti PROPERTIES
    # $<0:> prevents multi-config generators from appending Release/ or Debug/
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<0:>"
    DEBUG_POSTFIX ""
)

target_include_directories(tti PRIVATE ${LLVM_INCLUDE_DIRS} cpp/include)
target_compile_definitions(tti PRIVATE ${LLVM_DEFINITIONS})
target_compile_features(tti PRIVATE cxx_std_17)

if(MSVC)
    target_compile_options(tti PRIVATE
        /wd4244 /wd4267 /wd4100 /wd4324
        /wd4245 /wd4458 /wd4190 /wd4996
        /EHsc
    )
else()
    target_compile_options(tti PRIVATE -Wno-unused-parameter)
endif()

if(VTUNE_FOUND)
    message(STATUS "VTune support enabled: ${VTune_INCLUDE_DIRS}")
    target_compile_definitions(tti PRIVATE HAVE_VTUNE)
    target_include_directories(tti PRIVATE ${VTune_INCLUDE_DIRS})
    target_link_libraries(tti PRIVATE ${VTUNE_JITPROFILING_LIB})
else()
    message(STATUS "VTune not found")
endif()

target_link_libraries(tti PRIVATE ${LLVM_LIBS})