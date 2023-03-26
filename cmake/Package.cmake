# read version from file
file(READ ${PROJECT_SOURCE_DIR}/VERSION VERSION)
string(REPLACE "." ";" VERSION_LIST ${VERSION}) #convert string to list
list(GET VERSION_LIST 0 VERSION_MAJOR)
list(GET VERSION_LIST 1 VERSION_MINOR)
list(GET VERSION_LIST 2 VERSION_PATCH)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(${PROJECT_NAME}ConfigVersion.cmake
  VERSION ${VERSION}
  COMPATIBILITY SameMajorVersion
)

## cpack --config CPackSourceConfig.cmake
set(CPACK_GENERATOR "TGZ;DEB") #dpkg-deb -x <deb> <dir>
set(CPACK_SOURCE_GENERATOR "TGZ;DEB")
set(CPACK_NSIS_DISPLAY_NAME "CMake 3.20")
set(CPACK_OUTPUT_CONFIG_FILE ${CMAKE_BINARY_DIR})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Template C++ Package")
set(CPACK_PACKAGE_NAME ${CMAKE_PROJECT_NAME})
set(CPACK_PACKAGE_DIRECTORY ${CMAKE_PROJECT_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR ${VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${VERSION_PATCH})
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "DJ")
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON) # generate dependency information for .deb

## cpack will include every file in the root directory unless
# told to ignore certain files
list(APPEND CPACK_SOURCE_IGNORE_FILES ".git")
list(APPEND CPACK_SOURCE_IGNORE_FILES "build")
list(APPEND CPACK_SOURCE_IGNORE_FILES ".cache")
list(APPEND CPACK_SOURCE_IGNORE_FILES "CMakeLists.txt")
list(APPEND CPACK_SOURCE_IGNORE_FILES "VERSION")
list(APPEND CPACK_SOURCE_IGNORE_FILES "build.linux.sh")
list(APPEND CPACK_SOURCE_IGNORE_FILES ".clang-format")
list(APPEND CPACK_SOURCE_IGNORE_FILES ".projectile")

include(CPack)