#!/usr/bin/env bash
set -e
swiftc -typecheck $(find Sources apps -name '*.swift')
