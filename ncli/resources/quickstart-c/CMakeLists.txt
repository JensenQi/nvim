cmake_minimum_required(VERSION 3.12...3.21)

project({name} VERSION 0.1.0 LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # 避免 coc.clangd 查找不到头文件报 pp_file_not_found
Set(FETCHCONTENT_QUIET FALSE) # 开启 git 拉取进度

include(FetchContent)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")

add_subdirectory(src)
add_subdirectory(app)
add_subdirectory(test)

include(InstallRequiredSystemLibraries)
install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION bin)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR "${CMAKE_PROJECT_VERSION}")
set(CPACK_PACKAGE_VERSION_MINOR "")
SET(CPACK_PACKAGE_DIRECTORY "dist")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)

