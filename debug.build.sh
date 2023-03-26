#!/bin/bash

#######################
# make sure to install:
# sudo apt install libc++-15-dev libc++abi-15-dev
# sudo apt-get install libboost-all-dev
# llvm-15, follow this:
### wget -c https://apt.llvm.org/llvm.sh
### chmod +x llvm.sh
### sudo ./llvm.sh all
#######################

build_dir="build"

if [ "$1" == "--clean" ]; then
    echo "==> Clean build..."
    rm -rf $build_dir
fi

# Generate detailed information about cmake
cmake --system-information $build_dir/cmake_info.txt

cmake . -B $build_dir -G Ninja \
      -DCMAKE_BUILD_TYPE=DEBUG \
      -DCMAKE_CXX_COMPILER=clang++-15 \
      -DCMAKE_C_COMPILER=clang-15 \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
      -DOPT_ENABLE_UNIT_TEST=ON \
      -DOPT_COVERAGE_ENABLE=ON \
      -DOPT_COVERAGE_VERBOSE=ON \
      -DCMAKE_CXX_FLAGS=-stdlib=libc++                                    \
      -DCMAKE_EXE_LINKER_FLAGS=-stdlib=libc++

cmake --build $build_dir
cmake --install $build_dir

# symbolic link to compile_commands.json lsp-clangd should be able to find it
# inside output.build based on clangd documentation. However, it didn't and it
# seems it has to be in the root directory for it to work!
if [ ! -f compile_commands.json ]; then
    ln -s $build_dir/compile_commands.json ./
fi

# for packaging, run the following command
# cd output.build
# cpack --config CPackSourceConfig.cmake

# code coverage
# cd build/
# cmake --build . --target lib1Test_cov
# firefox bin/lib1Test_cov/index.html
