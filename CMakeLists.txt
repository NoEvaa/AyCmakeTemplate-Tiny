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

if(${${MODULE_NAME}_BUILD_SHARED})
  set(${MODULE_NAME}_LIB_TYPE SHARED)
else()
  set(${MODULE_NAME}_LIB_TYPE STATIC)
endif()

add_library(${MODULE_NAME} ${${MODULE_NAME}_LIB_TYPE})

target_include_directories(
  ${MODULE_NAME}
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src
)

add_library(${MODULE_NS}::${MODULE_NAME} ALIAS ${MODULE_NAME})
message(STATUS "Build `${${MODULE_NAME}_LIB_TYPE}` library `${MODULE_NS}::${MODULE_NAME}`")



file(GLOB children LIST_DIRECTORIES true "*")
foreach(child IN LISTS children)
	message("${child}")
endforeach()


