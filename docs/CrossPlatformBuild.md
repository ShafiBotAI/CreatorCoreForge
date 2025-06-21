# Cross-Platform Build Guide

This document explains how to generate macOS `.dmg` and Windows `.exe` installers for the CreatorCoreForge apps.

## Requirements
- Node.js 18 or later
- `electron-builder` (installed automatically by the build script)
- macOS and Windows build runners for signing and packaging

## Usage
Run the helper script from the repository root:

```bash
./scripts/build_desktop.sh
```

The script searches each app folder for a `Desktop` project containing a `package.json` file. If found, it installs dependencies and invokes `electron-builder` to create installers for both macOS and Windows.

An example desktop package is provided under `apps/CoreForgeAudio/Desktop`. Use it as a template when adding desktop builds for other apps.

Artifacts are generated under each app's `Desktop/dist` directory. Upload these installers to your distribution channel or attach them to a release.

## Continuous Integration
A GitHub Actions workflow (`desktop-build.yml`) is provided to automate the process. Trigger the workflow manually or on push. It executes the build script on both `macos-latest` and `windows-latest` runners.
