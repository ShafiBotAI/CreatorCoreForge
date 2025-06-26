#!/usr/bin/env python3
import sys
import uuid
import re
import os

PLACEHOLDER_PATTERN = re.compile(r"1{24}")

IDS = ["111111111111111111111111","111111111111111111111112","111111111111111111111113","111111111111111111111114","111111111111111111111115"]


def fix_file(path):
    with open(path) as f:
        content = f.read()
    changed = False
    for ph in IDS:
        if ph in content:
            new_id = uuid.uuid4().hex.upper()[:24]
            content = content.replace(ph, new_id)
            changed = True
    if changed:
        with open(path, 'w') as f:
            f.write(content)
    return changed


def main():
    if len(sys.argv) < 2:
        print("Usage: fix_placeholder_pbxproj.py <pbxproj paths>")
        return
    for p in sys.argv[1:]:
        if fix_file(p):
            print(f"Fixed {p}")

if __name__ == '__main__':
    main()
