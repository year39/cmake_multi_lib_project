
if(OPT_COVERAGE_ENABLE)

  include(CMakeParseArguments)

  option(OPT_COVERAGE_VERBOSE "Code coverage verbose information" ON)

  if(CMAKE_CXX_COMPILER_ID MATCHES "[Cc]lang")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 12)
      message(FATAL_ERROR "Clang version must be at least 12")
    endif()
  else()
    message(FATAL_ERROR "Compiler mismatch - Code coverage is enabled for clang v12")
  endif()

  if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(FATAL_ERROR "Build type must be debug to produce correct code coverage results")
  endif()

  find_program(LLVM_COV llvm-cov-15)
  if(NOT LLVM_COV)
    message(FATAL_ERROR "llvm-cov-15 not found")
  elseif(OPT_COVERAGE_VERBOSE)
    message(STATUS "==> Found llvm-cov: ${LLVM_COV}")
  endif()

  find_program(LLVM_PROFDATA llvm-profdata-15)
  if(NOT LLVM_PROFDATA)
    message(FATAL_ERROR "llvm-profdata-15 not found")
  elseif(OPT_COVERAGE_VERBOSE)
    message(STATUS "==> Found llvm-profdata: ${LLVM_PROFDATA}")
  endif()

  # compile with coverage enabled
  set(COVERAGE_CLANG_FLAGS "-fprofile-instr-generate -fcoverage-mapping")

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COVERAGE_CLANG_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COVERAGE_CLANG_FLAGS}")

  if(OPT_COVERAGE_VERBOSE)
    message(STATUS "==> Adding clang flags: ${COVERAGE_CLANG_FLAGS}")
  endif()
endif()

## Helper function to generate code coverage for the given test target
# if(OPT_COVERAGE_ENABLE)
#   add_code_coverage(
# 		TARGET test
# 		DEPENDS test)
# endif()

function(add_code_coverage)
  set(options NONE)
  set(oneValueArgs TARGET)
  set(multiValueArgs DEPENDS)
  cmake_parse_arguments(COVERAGE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT OPT_COVERAGE_ENABLE)
    message(STATUS "==> set OPT_COVERAGE_ENABLE=ON to enable code coverage")
    message(FATAL_ERROR "Code coverage not enabled - illegal call to (add_code_coverage)")
  endif()

  # append _cov to the target's name
  set(COVERAGE_NAME "${COVERAGE_TARGET}_cov")

  if(OPT_COVERAGE_VERBOSE)
    message(STATUS "==> Code coverage target: ${COVERAGE_NAME}")
  endif()

  # Setup target
  add_custom_target(${COVERAGE_NAME}

    # run the test target
    ${COVERAGE_TARGET}

    # reading TODO: https://cmake.org/cmake/help/v3.0/manual/cmake-generator-expressions.7.html

    COMMAND ${CMAKE_COMMAND} -E make_directory $<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}

    # copy the .profraw file to the targets directory
    COMMAND ${CMAKE_COMMAND} -E copy default.profraw  $<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}

    # generate .profdata fromt he raw profile
    COMMAND ${LLVM_PROFDATA} merge --sparse $<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}/default.profraw -o $<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}/default.profdata

    # print the report
    COMMAND ${LLVM_COV} report $<TARGET_FILE:${COVERAGE_TARGET}> -instr-profile=$<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}/default.profdata

    # generate .html report
    COMMAND ${LLVM_COV} show -format=html -output-dir=$<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME} $<TARGET_FILE:${COVERAGE_TARGET}> -instr-profile=$<TARGET_FILE_DIR:${COVERAGE_TARGET}>/${COVERAGE_NAME}/default.profdata

    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    DEPENDS ${COVERAGE_DEPENDS}
    COMMENT "==> Running llvm code coverage tools and generating report. "
    )

endfunction()
