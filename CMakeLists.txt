cmake_minimum_required(VERSION 3.5)

include(cmake2riot.cmake)

project(cmake2riot_test)

add_executable(${PROJECT_NAME}
    test.c
)

install(TARGETS ${PROJECT_NAME})
