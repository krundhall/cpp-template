#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BD="$ROOT/build"

# Optional:
#   VERBOSE=1 ./scripts/build.sh
#   WERROR=0  ./scripts/build.sh
#
# WERROR controls the CMake option ENABLE_WERROR (default ON).
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
