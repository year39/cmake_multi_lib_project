
##################################################
# boost library
FIND_PACKAGE( Boost 1.71.0 REQUIRED )
IF (Boost_FOUND)
  message(STATUS "Boost v${Boost_VERSION} found")
  INCLUDE_DIRECTORIES( ${Boost_INCLUDE_DIR})
endif()

add_library(lib2 STATIC
    include/lib2/lib2.h
    src/prog2.cpp
)
add_library(${PROJECT_NAME}::lib2 ALIAS lib2)

target_include_directories(lib2
  PUBLIC
  	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  PRIVATE
  	${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(lib2
  ${Boost_LIBRARIES}
)

target_compile_options(lib2 PRIVATE -Wall -Wextra)
target_compile_features(lib2 PRIVATE cxx_std_17)

install(TARGETS lib2
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/lib2
    DESTINATION include
)
