#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
APP_DIR="${BUILD_DIR}/CatsLock.app"
DMG_PATH="${BUILD_DIR}/CatsLock-Installer.dmg"
SIGNING_IDENTITY="${CODESIGN_IDENTITY:--}"

mkdir -p "${APP_DIR}/Contents/MacOS" "${APP_DIR}/Contents/Resources"
swiftc -typecheck "${ROOT_DIR}/main.swift"
swiftc -O -o "${APP_DIR}/Contents/MacOS/CatsLock" "${ROOT_DIR}/main.swift"
cp "${ROOT_DIR}/packaging/Info.plist" "${APP_DIR}/Contents/Info.plist"
cp "${ROOT_DIR}/CatsLock.icns" "${APP_DIR}/Contents/Resources/CatsLock.icns"
codesign --force --deep --sign "${SIGNING_IDENTITY}" --timestamp=none "${APP_DIR}"
codesign --verify --deep --strict "${APP_DIR}"

STAGING_DIR="$(mktemp -d "${BUILD_DIR}/.CatsLock-dmg.XXXXXX")"
trap 'rm -rf "${STAGING_DIR}"' EXIT
ditto "${APP_DIR}" "${STAGING_DIR}/CatsLock.app"
ln -s /Applications "${STAGING_DIR}/Applications"
hdiutil create \
    -volname "CatsLock Installer" \
    -srcfolder "${STAGING_DIR}" \
    -format UDZO \
    -ov \
    "${DMG_PATH}"
hdiutil verify "${DMG_PATH}"

printf 'Built app: %s\nBuilt installer: %s\n' "${APP_DIR}" "${DMG_PATH}"
