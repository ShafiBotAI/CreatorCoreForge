# Cross-Platform Build Guide

This document explains how to generate installers and deployable builds for all supported platforms: iOS, Android, macOS, Windows, Web, Chrome, and Edge.

## Requirements
- Node.js 18 or later
- `electron-builder` (installed automatically by the build script)
- macOS and Windows build runners for signing and packaging
- `wine` and `mono` (required on macOS/Linux hosts to build Windows installers)

## Usage
Run the desktop helper script from the repository root:

```bash
./scripts/build_desktop.sh
```

The script searches each app folder for a `Desktop` project containing a `package.json` file. If found, it installs dependencies and invokes `electron-builder` to create installers for both macOS and Windows.

Each app now includes a `Desktop` folder with a minimal Electron setup. Use these as templates when customizing the builds for your project.

Artifacts are generated under each app's `Desktop/dist` directory. Upload these installers to your distribution channel or attach them to a release.

## Mobile and Web Builds

Use the universal build helper to generate all remaining targets:

```bash
./scripts/universal_build.sh
```

This script performs the following actions when the necessary tools are available:

1. **iOS** – invokes Fastlane to build every Xcode project under `apps/`.
2. **Android** – runs `./gradlew assembleRelease` for any Android projects.
3. **Web** – executes `npm install` and `npm run build` for each `Web` directory.
4. **Desktop** – calls `build_desktop.sh` for macOS, Windows, and Linux installers.
5. **PWA** – runs `npm run build:pwa` when the script is defined in a `Web` project.
6. **Chrome/Edge** – builds browser extensions when `extensions/chrome` or `extensions/edge` exist.
7. **Next‑Gen** – invokes `quantum-builder` for advanced targets when available.

## Continuous Integration
A GitHub Actions workflow (`desktop-build.yml`) is provided to automate the process. Trigger the workflow manually or on push. It executes the build script on both `macos-latest` and `windows-latest` runners.
