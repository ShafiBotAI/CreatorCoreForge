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

# run Swift tests
swift test
