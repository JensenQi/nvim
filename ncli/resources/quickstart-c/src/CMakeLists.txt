file(GLOB HEADER_LIST CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/include/*.h")
file(GLOB SRC_LIST CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/*.c")

add_library(${PROJECT_NAME}_lib ${SRC_LIST} ${HEADER_LIST})

target_include_directories(${PROJECT_NAME}_lib PUBLIC ${PROJECT_SOURCE_DIR}/include)
