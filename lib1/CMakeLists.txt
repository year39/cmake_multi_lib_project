
##################################################
# sd-bus library
find_package(PkgConfig REQUIRED)
pkg_check_modules(SYSTEMD "libsystemd" REQUIRED) #install libsystemd-dev
if(NOT SYSTEMD_FOUND)
  message(FATAL_ERROR "ERROR: Systemd not found! Make sure to install libsystemd-dev")
endif(NOT SYSTEMD_FOUND)

add_library(lib1 STATIC
    include/lib1/lib1.h
    src/prog1.cpp
)
add_library(${PROJECT_NAME}::lib1 ALIAS lib1)

target_include_directories(lib1
  PUBLIC
  	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(lib1
  ${SYSTEMD_LIBRARIES}
)

target_compile_options(lib1 PRIVATE -Wall -Wextra)
target_compile_features(lib1 PRIVATE cxx_std_17)

install(TARGETS lib1
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/lib1
  DESTINATION include
)

add_subdirectory(test)
