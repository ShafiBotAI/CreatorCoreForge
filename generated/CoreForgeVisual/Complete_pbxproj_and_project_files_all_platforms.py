# Auto-generated for Complete `.pbxproj` and project files (all platforms)
from __future__ import annotations

from pathlib import Path


TEMPLATE = """
// !PBX project
"""


def complete_pbxproj_and(output_dir: str) -> Path:
    """Write a minimal `.pbxproj` file to ``output_dir`` and return its path."""

    path = Path(output_dir) / "project.pbxproj"
    path.write_text(TEMPLATE)
    return path
