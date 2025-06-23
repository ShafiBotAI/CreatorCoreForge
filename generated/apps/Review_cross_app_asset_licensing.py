# Auto-generated for Review cross-app asset licensing
"""Scan application folders for asset license files."""

from __future__ import annotations

import os
from pathlib import Path


def review_cross_app(apps_dir: str = "apps") -> list[str]:
    """Return a list of app folders missing a ``LICENSE`` or ``LICENSE.md`` file."""

    missing: list[str] = []
    for app in Path(apps_dir).iterdir():
        if not app.is_dir() or app.name.startswith("."):
            continue

        has_license = any((app / name).exists() for name in ["LICENSE", "LICENSE.md"])
        if not has_license:
            missing.append(app.name)

    for app in missing:
        print(f"Missing license for {app}")

    if not missing:
        print("All app folders include license files.")

    return missing


if __name__ == "__main__":
    review_cross_app()

