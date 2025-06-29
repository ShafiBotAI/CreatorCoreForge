#!/usr/bin/env bash
set -e
swiftc -warnings-as-errors -typecheck $(find Sources apps -name '*.swift')
