FetchContent_Declare(
  cmocka
  GIT_REPOSITORY https://gitlab.com/cmocka/cmocka.git
  GIT_TAG cmocka-1.1.7
  GIT_PROGRESS TRUE
  SOURCE_DIR ${PROJECT_SOURCE_DIR}/3rdparty/cmocka)

if(EXISTS ${PROJECT_SOURCE_DIR}/3rdparty/cmocka)
  add_subdirectory(${PROJECT_SOURCE_DIR}/3rdparty/cmocka cmocka)
else()
  FetchContent_MakeAvailable(cmocka)
endif()
