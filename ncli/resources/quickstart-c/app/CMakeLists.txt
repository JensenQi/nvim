add_executable(${PROJECT_NAME} ${PROJECT_NAME}.c)

target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_lib)

