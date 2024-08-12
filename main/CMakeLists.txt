# Main
# 

file(
    GLOB
    ${PROJECT_NAME}_MAIN_FILES
    *.cc *.cpp *.c
)

add_executable(${PROJECT_NAME}_main ${${PROJECT_NAME}_MAIN_FILES})
target_link_libraries(${PROJECT_NAME}_main PUBLIC ${MODULE_NS}::${MODULE_NAME})
