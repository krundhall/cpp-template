#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cmake -S "$ROOT" -B "$ROOT/build"
cmake --build "$ROOT/build"

proj_name="$(grep -E '^CMAKE_PROJECT_NAME:STATIC=' "$ROOT/build/CMakeCache.txt" | cut -d= -f2)"

exec "$ROOT/build/$proj_name" "$@"
