#!/bin/bash
set -e
# Run tests for VoiceLab
cd "$(dirname "$0")/.." # go to repo root

# run VoiceLab tests
pushd VoiceLab >/dev/null
npm test
popd >/dev/null

# run VisualLab tests
pushd VisualLab >/dev/null
npm test
popd >/dev/null

# run CoreForgeBuild tests
pushd apps/CoreForgeBuild >/dev/null
npm test
popd >/dev/null

# run Swift tests only on macOS to avoid platform crashes
if command -v swift >/dev/null; then
    if [[ "$(uname)" == "Darwin" ]]; then
        swift test
    else
        echo "Skipping Swift tests on non-macOS system"
    fi
fi
