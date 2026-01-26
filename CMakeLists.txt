cmake_minimum_required(VERSION 3.20)
project(zed-test LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Toggle warnings-as-errors (default ON)
option(ENABLE_WERROR "Treat warnings as errors" ON)

add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

if (MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        /W4
        /permissive-
        $<$<BOOL:${ENABLE_WERROR}>:/WX>
    )
else()
    target_compile_options(${PROJECT_NAME} PRIVATE
        -Wall
        -Wextra
        -Wpedantic
        $<$<BOOL:${ENABLE_WERROR}>:-Werror>
    )
endif()
