# Auto-generated for All `.pbxproj`/multi-platform project files

import os

def all_pbxproj_multi(directory: str) -> list:
    """Return list of pbxproj files under a directory."""
    results = []
    for root, _, files in os.walk(directory):
        for f in files:
            if f.endswith('.pbxproj'):
                results.append(os.path.join(root, f))
    return results
