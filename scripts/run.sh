#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BD="$ROOT/build"

# Optional:
#   VERBOSE=1 ./scripts/run.sh
#   WERROR=0  ./scripts/run.sh
WERROR_FLAG="-DENABLE_WERROR=ON"
if [[ "${WERROR:-1}" == "0" ]]; then
  WERROR_FLAG="-DENABLE_WERROR=OFF"
fi

if [[ "${VERBOSE:-0}" == "1" ]]; then
  cmake -S "$ROOT" -B "$BD" $WERROR_FLAG
  cmake --build "$BD"
else
  cmake -S "$ROOT" -B "$BD" $WERROR_FLAG --log-level=ERROR >/dev/null
  cmake --build "$BD" >/dev/null
fi

# Assumes your main executable target name == project name (your pattern).
proj_name="$(grep -E '^CMAKE_PROJECT_NAME:STATIC=' "$BD/CMakeCache.txt" | cut -d= -f2)"
exec "$BD/$proj_name" "$@"
