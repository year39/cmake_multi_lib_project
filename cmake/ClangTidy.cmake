###
# clang-tidy
if(OPT_ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_PROGRAM NAMES clang-tidy-13)
  if(NOT CLANG_TIDY_PROGRAM)
    message(WARNING "==> clang-tidy not found!")
  else()
    set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY_PROGRAM} -extra-arg=-Wno-unknown-warning-option)
  endif()
endif()
