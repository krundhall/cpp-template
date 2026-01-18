#!/usr/bin/env bash
set -euo pipefail
cmake --preset asan
cmake --build --preset asan
