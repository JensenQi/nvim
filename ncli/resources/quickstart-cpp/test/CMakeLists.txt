include(googletest)

file(GLOB TEST_LIST CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/test/*.cpp")

add_executable(testall ${TEST_LIST})

target_link_libraries(testall PRIVATE ${PROJECT_NAME}_lib gtest)

