### Note about cmake variables:
# You set the variables in this file to the defaults.
# Those variables will be overriden if externally passed as arguments to cmake.

###
# cmake --install uses this variable to determine the install dir
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "" FORCE)

###
# cmake --build uses the next two variables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

###
# default build type is Debug
set(CMAKE_BUILD_TYPE Debug)

###
# generate compile_commands.json if debug build
message("==> Build Type: ${CMAKE_BUILD_TYPE}")
if (CMAKE_BUILD_TYPE MATCHES "Debug")
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
else()
  set(CMAKE_EXPORT_COMPILE_COMMANDS OFF)
endif()

###
# do not install googletest targets
set(INSTALL_GTEST OFF)

###
# unit testing
option(OPT_ENABLE_UNIT_TEST "Enable unit tests (gtest & gmock)" ON)

###
# clang-tidy
option(OPT_ENABLE_CLANG_TIDY "Enable static analysis (Clang-Tidy)" OFF)

###
# code coverage
option(OPT_ENABLE_CODE_COVERAGE "Enable code coverage" OFF)

###
# doxygen documentation
option(OPT_ENABLE_DOXYGEN "Enable Doxygen documentation" OFF)
