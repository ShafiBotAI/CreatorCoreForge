# Auto-generated for Coordinate shared assets and templates
"""Distribute shared asset templates across application folders."""

from __future__ import annotations

import shutil
from pathlib import Path


def coordinate_shared_assets(apps_dir: str = "apps", template_dir: str = "scripts/templates") -> None:
    """Copy files from ``template_dir`` into each application's ``templates`` folder."""

    source = Path(template_dir)
    if not source.is_dir():
        raise FileNotFoundError(f"Template directory {template_dir!s} missing")

    for app in Path(apps_dir).iterdir():
        if not app.is_dir() or app.name.startswith("."):
            continue

        target = app / "templates"
        target.mkdir(exist_ok=True)

        for tpl in source.iterdir():
            if tpl.is_file():
                shutil.copy2(tpl, target / tpl.name)
        print(f"Updated templates for {app.name}")


if __name__ == "__main__":
    coordinate_shared_assets()

