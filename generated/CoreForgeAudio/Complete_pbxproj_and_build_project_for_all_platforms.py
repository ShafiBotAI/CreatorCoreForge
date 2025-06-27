# Auto-generated for Complete `.pbxproj` and build project for all platforms
"""Utility helpers for creating a minimal Xcode `.pbxproj` file."""

from __future__ import annotations

from pathlib import Path


def create_pbxproj(project_name: str, out_dir: str | Path) -> Path:
    """Create a bare-bones pbxproj and return its path."""
    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    project_path = out_dir / f"{project_name}.pbxproj"
    if not project_path.exists():
        project_path.write_text(f"// !PBX project for {project_name}\n")
    return project_path


__all__ = ["create_pbxproj"]
