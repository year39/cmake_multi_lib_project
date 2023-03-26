###
# gtest & gmock
if(OPT_ENABLE_UNIT_TEST)
  include(FetchContent)
  fetchcontent_declare(
    googletest
    GIT_REPOSITORY git@github.com:google/googletest.git
    GIT_TAG release-1.11.0
  )
  fetchcontent_makeavailable(googletest)

  # enable_testing() generates CTestTestfile.cmake, which is used by ctest to run
  # all the tests. For example, cd build and then run ctest will run all the
  # registered tests. Otherwise, you still can run the tests but you need to run
  # them individually executables
  enable_testing()

  include(GoogleTest)

  function(add_test_executable test_name depends)
    if(PROJECT_IS_TOP_LEVEL)
      add_executable(${test_name} ${depends})
      target_link_libraries(${test_name} gtest gmock gtest_main ${ARGN})

      # intended to replace use of add_test() to register tests
      gtest_discover_tests(${test_name})
    endif()
  endfunction()

endif()
