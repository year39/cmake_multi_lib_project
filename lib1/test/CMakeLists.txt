add_test_executable (lib1Test lib1Test.cpp ${PROJECT_NAME}::lib1)

if(OPT_COVERAGE_ENABLE)
  add_code_coverage(
		TARGET lib1Test
		DEPENDS lib1Test)
endif()
