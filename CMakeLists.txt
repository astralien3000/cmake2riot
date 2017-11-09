cmake_minimum_required(VERSION 3.5)

project(cmake2riot_test)

add_executable(${PROJECT_NAME} test.c)

install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    )
