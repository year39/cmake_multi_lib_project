This is a template/example that can be used to build a monolithic C++ application with multiple libraries embedded as part of
the application's root directory. It includes unit tests and code coverage using llvm-cov.

![write_up(1)](https://user-images.githubusercontent.com/70146464/227763852-1f6ceccc-0734-4502-81d1-fa36aac68e5e.png)


# Required packages

## LLVM-15

```sh
wget -c https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh all
```

## Boost library

```sh
sudo apt-get install libboost-all-dev
```

## libc++ standard library

```sh
sudo apt install libc++-15-dev libc++abi-15-dev
```

## cmake (v3.20 or higher)

```sh
wget -c https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.sh -O cmake.sh
chmod +x cmake.sh
./cmake.sh --prefix=<path-if-different-than-default> --skip-license
# if --prefix is used, make sure to update $PATH
```

# Build

```sh
./debug.build.sh
```

# Test

```sh
cd build/
ctest
```

output:

```sh
Test project cmake_multi_lib_project/build
    Start 1: lib1Test.helloTest
1/2 Test #1: lib1Test.helloTest ...............   Passed    0.00 sec
    Start 2: lib1Test.getByteTest
2/2 Test #2: lib1Test.getByteTest .............   Passed    0.00 sec

100% tests passed, 0 tests failed out of 2

Total Test time (real) =   0.00 sec

```

# Code coverage

Code coverage is added to lib1 test target. To run the coverage report:

```sh
cd build/
cmake --build . --target lib1Test_cov
```

output:

```sh
[1/1] ==> Running llvm code coverage tools and generating report.
Running main() from cmake_multi_lib_project/build/_deps/googletest-src/googletest/src/gtest_main.cc
[==========] Running 2 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 2 tests from lib1Test
[ RUN      ] lib1Test.helloTest
[       OK ] lib1Test.helloTest (0 ms)
[ RUN      ] lib1Test.getByteTest
[       OK ] lib1Test.getByteTest (0 ms)
[----------] 2 tests from lib1Test (0 ms total)

[----------] Global test environment tear-down
[==========] 2 tests from 1 test suite ran. (0 ms total)
[  PASSED  ] 2 tests.
Filename                      Regions    Missed Regions     Cover   Functions  Missed Functions  Executed       Lines      Missed Lines     Cover    Branches   Missed Branches     Cover
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src/prog1.cpp                       6                 4    33.33%           3                 1    66.67%          17                11    35.29%           2                 2     0.00%
test/lib1Test.cpp                   2                 0   100.00%           2                 0   100.00%           6                 0   100.00%           0                 0         -
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TOTAL                               8                 4    50.00%           5                 1    80.00%          23                11    52.17%           2                 2     0.00%
```

Code coverage `html` report:

```sh
firefox bin/lib1Test_cov/index.html
```

![code-coverage](https://user-images.githubusercontent.com/70146464/227749431-80c665f2-02b8-4ebd-a1f7-88b9dbad56c0.png)
