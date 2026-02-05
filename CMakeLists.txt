cmake_minimum_required(VERSION 3.22)

project(CPPTEMPLATE
    VERSION 0.1.0
    DESCRIPTION "Template for simple C++ apps (raylib GUI etc.)"
    LANGUAGES CXX
)

# ────────────────────────────────────────────────
# Global settings – adjust here if needed
# ────────────────────────────────────────────────
set(CMAKE_CXX_STANDARD          20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

# Output directories – keeps build clean
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Export compile_commands.json for clangd / LSP
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Static MSVC runtime for better portability (single exe friendly)
if(MSVC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

# ────────────────────────────────────────────────
# Main executable
# ────────────────────────────────────────────────
add_executable(${PROJECT_NAME}
    src/main.cpp
    # ADD OTHER SOURCE FILES HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Compiler warnings – helpful but not overwhelming
target_compile_options(${PROJECT_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4 /WX /permissive->
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic -Wshadow -Wconversion>
)

# ────────────────────────────────────────────────
# Dependencies (FetchContent) – uncomment what you need per project
# ────────────────────────────────────────────────
include(FetchContent)
FetchContent_MakeAvailable()  # dummy call so we can declare below

# raylib – latest stable as of Feb 2026 is 5.5 (Nov 2024)
 FetchContent_Declare(
     raylib
     GIT_REPOSITORY https://github.com/raysan5/raylib.git
     GIT_TAG        5.5
     GIT_SHALLOW    TRUE
 )
 set(RAYLIB_IS_MAIN OFF)
 set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
 set(BUILD_GAMES    OFF CACHE BOOL "" FORCE)
 FetchContent_MakeAvailable(raylib)
 target_link_libraries(${PROJECT_NAME} PRIVATE raylib)

# rapidcsv – header-only CSV parser, latest ~v8.90 (Nov 2025)
 FetchContent_Declare(
     rapidcsv
     GIT_REPOSITORY https://github.com/d99kris/rapidcsv.git
     GIT_TAG        v8.90
     GIT_SHALLOW    TRUE
 )
 FetchContent_MakeAvailable(rapidcsv)
 target_include_directories(${PROJECT_NAME} SYSTEM PRIVATE ${rapidcsv_SOURCE_DIR}/src)

# Other common ones you might want later:
# nlohmann_json, fmt, spdlog, googletest, etc.

# ────────────────────────────────────────────────
# Platform-specific
# ────────────────────────────────────────────────
if(WIN32)
    # Link Windows libs raylib usually needs
    target_link_libraries(${PROJECT_NAME} PRIVATE winmm)

    # Optional: no console window for pure GUI app
    # set_target_properties(${PROJECT_NAME} PROPERTIES WIN32_EXECUTABLE TRUE)
endif()

if(UNIX AND NOT APPLE)
    # Common Linux extras (raylib often needs these)
    find_package(Threads REQUIRED)
    target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
endif()

# Optional: copy assets/ folder to bin/ (fonts, csv examples later)
# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy_directory
#             ${CMAKE_SOURCE_DIR}/assets ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/assets
# )
