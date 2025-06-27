# Auto-generated for Build `.dmg` and `.exe` installers
"""Utility to package app directories as simple archives."""

from __future__ import annotations
import os
import shutil


def build_dmg_and(source_dir: str, output_dir: str) -> dict[str, str]:
    """Create zip archives representing installers for macOS and Windows."""
    os.makedirs(output_dir, exist_ok=True)
    dmg_path = shutil.make_archive(os.path.join(output_dir, "app"), "zip", source_dir)
    exe_path = shutil.make_archive(os.path.join(output_dir, "app-win"), "zip", source_dir)
    return {"dmg": dmg_path, "exe": exe_path}


__all__ = ["build_dmg_and"]
