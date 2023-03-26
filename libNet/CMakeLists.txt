
##################################################
# openssl library
find_package(OpenSSL REQUIRED)
if(NOT OPENSSL_FOUND)
  message(FATAL_ERROR "ERROR: OpenSSL not found!")
endif()

include(FetchContent)
FetchContent_Declare(mongoose
  URL                    https://github.com/cesanta/mongoose/archive/refs/tags/7.6.tar.gz
  #URL_HASH               SHA256=f5c10346abc9c72f7cac7885d853ca064fb09aad57580433941a8fd7a3543769 # the hash for 6.18.tar.gz
  USES_TERMINAL_DOWNLOAD TRUE)   # <---- This is needed only for Ninja to show download progress

# FetchContent_MakeAvailable not available for mongoose,
# we need to patch mongoose to use CMake
if (NOT mongoose_POPULATED)
  FetchContent_POPULATE(mongoose)

  file(INSTALL cmake/Mongoose.CMakeLists.txt DESTINATION ${mongoose_SOURCE_DIR})
  file(RENAME ${mongoose_SOURCE_DIR}/Mongoose.CMakeLists.txt ${mongoose_SOURCE_DIR}/CMakeLists.txt)
  add_subdirectory(${mongoose_SOURCE_DIR} ${mongoose_BINARY_DIR})

endif()

add_library(libNet STATIC
    include/libNet/libNet.h
    src/prog1.cpp
)
add_library(${PROJECT_NAME}::libNet ALIAS libNet)

target_include_directories(libNet
  PUBLIC
  	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  PRIVATE
    ${mongoose_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# if we link libNet against mongoose, the install will fail because
# cmake cannot find mongoose exports (it's an external package).
# This is why the library is linked against ${mongoose_SOURCE_DIR}
# target_link_libraries(libNet ${PROJECT_NAME}::mongoose) # DON'T DO THIS

target_compile_options(libNet PRIVATE -Wall -Wextra)
target_compile_features(libNet PRIVATE cxx_std_17)

install(TARGETS libNet
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/libNet
  DESTINATION include
)

