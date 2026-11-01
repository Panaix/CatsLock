#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/purrlock-icon.XXXXXX")"
trap 'rm -rf "${TEMP_DIR}"' EXIT

cd "${ROOT_DIR}"
swift scripts/generate-icon.swift
iconutil --convert icns \
    --output "${TEMP_DIR}/PurrLock.icns" \
    "${ROOT_DIR}/PurrLock.iconset"
mv "${TEMP_DIR}/PurrLock.icns" "${ROOT_DIR}/PurrLock.icns"
