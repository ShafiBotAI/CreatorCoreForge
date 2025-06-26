#!/bin/bash
set -e
# Clean install Node dependencies for all workspaces
cd "$(dirname "$0")/.."
rm -rf node_modules
npm ci
for dir in VoiceLab VisualLab apps/CoreForgeBuild; do
    rm -rf "$dir/node_modules"
    (cd "$dir" && npm ci)
done
