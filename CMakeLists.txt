cmake_minimum_required(VERSION 3.15)

# ==================================================
# Project

project(
    AyTiny
    VERSION 0.1.0
    LANGUAGES CXX
)

# Module: namespace::name
set(MODULE_NAME aytiny)
set(MODULE_NS ayin)

string(TOUPPER "${MODULE_NAME}" MODULE_NAME_UPPER)

# ==================================================

include(GenerateExportHeader)

# Project options
include(cmake/Options.cmake)
# Utils 
include(cmake/Utils.cmake)
# Init cmake environment
include(cmake/Init.cmake)

# Third party
#add_subdirectory(third_party)

# ==================================================
# Module library
if(${PROJECT_NAME}_BUILD_SHARED)
    set(${MODULE_NAME}_LIB_TYPE SHARED)
else()
    set(${MODULE_NAME}_LIB_TYPE STATIC)
endif()

file(GLOB_RECURSE ${MODULE_NAME}_HEADERS
    CONFIGURE_DEPENDS
    "include/*.h" "include/*.hpp"
    "include/*.inl" "include/*.tcc"
)

file(GLOB_RECURSE ${MODULE_NAME}_SOURCES
    CONFIGURE_DEPENDS
    "src/*.cc" "src/*.cpp" "src/*.c"
    "src/*.h" "src/*.hpp"
    "src/*.inl" "src/*.tcc"
)

add_library(
    ${MODULE_NAME}
    ${${MODULE_NAME}_LIB_TYPE}
    ${${MODULE_NAME}_HEADERS}
    ${${MODULE_NAME}_SOURCES}
)

if(NOT ${PROJECT_NAME}_BUILD_SHARED)
    target_compile_definitions(${MODULE_NAME} PUBLIC ${MODULE_NAME_UPPER}_STATIC_DEFINE)
endif()

generate_export_header(
    ${MODULE_NAME}
    BASE_NAME ${MODULE_NAME}
    EXPORT_FILE_NAME "${CMAKE_BINARY_DIR}/ext_include/${MODULE_NAME}/export.h"
    STATIC_DEFINE "${MODULE_NAME_UPPER}_STATIC_DEFINE"
)

target_include_directories(
    ${MODULE_NAME}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
    PUBLIC ${CMAKE_BINARY_DIR}/ext_include
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src
)

add_library(${MODULE_NS}::${MODULE_NAME} ALIAS ${MODULE_NAME})
message(STATUS "Build `${${MODULE_NAME}_LIB_TYPE}` library `${MODULE_NS}::${MODULE_NAME}`")

# ==================================================
# Project development environment 

if(${PROJECT_NAME}_IS_MAIN)
    # Main
    add_subdirectory(main)
endif()

