#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
APP_DIR="${BUILD_DIR}/PurrLock.app"
DMG_PATH="${BUILD_DIR}/PurrLock-Installer.dmg"
SIGNING_IDENTITY="${CODESIGN_IDENTITY:--}"
VERSION="${VERSION:-$(git -C "${ROOT_DIR}" describe --tags --exact-match 2>/dev/null || echo 1.0.0)}"
VERSION="${VERSION#v}"
BUILD_NUMBER="${BUILD_NUMBER:-1}"
MINIMUM_MACOS_VERSION="13.0"

mkdir -p "${APP_DIR}/Contents/MacOS" "${APP_DIR}/Contents/Resources" "${BUILD_DIR}/.purrlock-compile"
COMPILE_DIR="${BUILD_DIR}/.purrlock-compile"
STAGING_DIR=""
cleanup() {
    rm -rf "${COMPILE_DIR}"
    if [[ -n "${STAGING_DIR}" ]]; then
        rm -rf "${STAGING_DIR}"
    fi
}
trap cleanup EXIT

"${ROOT_DIR}/scripts/generate-icon.sh"
swiftc -typecheck "${ROOT_DIR}/main.swift"
swiftc -O -target "arm64-apple-macosx${MINIMUM_MACOS_VERSION}" \
    -o "${COMPILE_DIR}/PurrLock-arm64" "${ROOT_DIR}/main.swift"
swiftc -O -target "x86_64-apple-macosx${MINIMUM_MACOS_VERSION}" \
    -o "${COMPILE_DIR}/PurrLock-x86_64" "${ROOT_DIR}/main.swift"
lipo -create \
    "${COMPILE_DIR}/PurrLock-arm64" \
    "${COMPILE_DIR}/PurrLock-x86_64" \
    -output "${APP_DIR}/Contents/MacOS/PurrLock"
cp "${ROOT_DIR}/packaging/Info.plist" "${APP_DIR}/Contents/Info.plist"
cp "${ROOT_DIR}/PurrLock.icns" "${APP_DIR}/Contents/Resources/PurrLock.icns"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${VERSION}" \
    "${APP_DIR}/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${BUILD_NUMBER}" \
    "${APP_DIR}/Contents/Info.plist"
codesign --force --deep --sign "${SIGNING_IDENTITY}" --timestamp=none "${APP_DIR}"
codesign --verify --deep --strict "${APP_DIR}"

STAGING_DIR="$(mktemp -d "${BUILD_DIR}/.PurrLock-dmg.XXXXXX")"
ditto "${APP_DIR}" "${STAGING_DIR}/PurrLock.app"
ln -s /Applications "${STAGING_DIR}/Applications"
hdiutil create \
    -volname "PurrLock Installer" \
    -srcfolder "${STAGING_DIR}" \
    -format UDZO \
    -ov \
    "${DMG_PATH}"
hdiutil verify "${DMG_PATH}"

printf 'Built app: %s\nBuilt installer: %s\n' "${APP_DIR}" "${DMG_PATH}"
