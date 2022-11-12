cmake_minimum_required(VERSION 3.20)
project("rr_cmake" VERSION 1.0.1
             DESCRIPTION "cmake macros"
             HOMEPAGE_URL "https://github.com/reder2000/rr_cmake")

include(GNUInstallDirs)

FILE(GLOB_RECURSE cmakefiles CONFIGURE_DEPENDS rr_cmake/*.cmake)
source_group("cmakefiles" FILES ${cmakefiles})

#include(${CMAKE_SOURCE_DIR}/rr_cmake/git_include.cmake)
#git_includee(my_package https://mygithub/exmaple.git BRANCH dev SOURCEDIR mydir)
#git_includee(my_package https://mygithub/exmaple.git)

# define a header-only library
add_library(rr_cmake INTERFACE  ${cmakefiles} README.md)
add_library(rr_cmake::rr_cmake ALIAS rr_cmake)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

target_link_libraries(rr_cmake INTERFACE)

target_include_directories(
  ${PROJECT_NAME}
  INTERFACE $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/rr_cmake/>
            $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}_Targets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_NAME}ConfigVersion.cmake"
                                 VERSION ${PROJECT_VERSION}
                                 COMPATIBILITY SameMajorVersion
                                 ARCH_INDEPENDENT)

set(INCLUDE_INSTALL_DIR include/ ... CACHE PATH "include rr_cmake")
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/dummy-config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
  ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake
  PATH_VARS INCLUDE_INSTALL_DIR )

install(EXPORT ${PROJECT_NAME}_Targets
        FILE ${PROJECT_NAME}Targets.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)


install(FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
              "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)


install(DIRECTORY rr_cmake/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/rr_cmake)

# check includes
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
include(rr_cmake/FindVcpkInstall)
include(rr_cmake/cxx20)
include(rr_cmake/visual_source_group)
include(rr_cmake/common)
