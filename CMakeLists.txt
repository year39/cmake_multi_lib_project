cmake_minimum_required(VERSION 3.20)
project(template-cmake)

set(CMAKE_CXX_STANDARD 20)

###
# follow new cmake policy (no backward compatibility with old versions)
set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

###
# cpack if this is the root project
if(PROJECT_IS_TOP_LEVEL)
  include(cmake/StandardSettings.cmake)
  include(cmake/CompilerWarnings.cmake)
  include(cmake/Depends.cmake)
  include(cmake/Package.cmake)
  include(cmake/Install.cmake)
  include(cmake/GTest.cmake)
  include(cmake/ClangTidy.cmake)
  include(cmake/CodeCoverage.cmake)
  include(cmake/Doxygen.cmake)
endif()

add_subdirectory(lib1)
add_subdirectory(lib2)
add_subdirectory(libNet)
add_subdirectory(app)
