FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://gitee.com/mirrors/googletest.git
  GIT_TAG v1.14.0
  GIT_PROGRESS TRUE
  SOURCE_DIR ${PROJECT_SOURCE_DIR}/3rdparty/googletest)

if(EXISTS ${PROJECT_SOURCE_DIR}/3rdparty/googletest)
  add_subdirectory(${PROJECT_SOURCE_DIR}/3rdparty/googletest googletest)
else()
  FetchContent_MakeAvailable(googletest)
endif()
