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

# ==================================================

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

target_include_directories(
    ${MODULE_NAME}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
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

