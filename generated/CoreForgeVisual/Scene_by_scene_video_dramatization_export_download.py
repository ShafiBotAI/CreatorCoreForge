# Auto-generated for Scene-by-scene video dramatization, export/download
"""Utility for turning scenes into mock video file names."""

from typing import Iterable, List


def scene_by_scene(scenes: Iterable[str]) -> List[str]:
    """Return a list of exported file names for ``scenes``."""

    return [f"scene_{i}.mp4" for i, _ in enumerate(scenes)]


__all__ = ["scene_by_scene"]
