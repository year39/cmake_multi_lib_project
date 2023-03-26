add_executable(app
    src/main.cpp
)

target_link_libraries(app PRIVATE
  ${PROJECT_NAME}::lib1
  ${PROJECT_NAME}::lib2
  ${PROJECT_NAME}::libNet
  ${PROJECT_NAME}::mongoose
)

target_compile_options(app PRIVATE -Wall -Wextra)
target_compile_features(app PRIVATE cxx_std_17)

install(TARGETS app
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION bin
)
