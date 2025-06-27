# Auto-generated for Preserve scene framing consistency across languages
from __future__ import annotations

from typing import Dict


def preserve_scene_framing(base_coords: Dict[str, float], translation_offset: Dict[str, float]) -> Dict[str, float]:
    """Apply ``translation_offset`` to ``base_coords`` to keep framing consistent."""

    return {
        axis: base_coords.get(axis, 0.0) + translation_offset.get(axis, 0.0)
        for axis in {"x", "y", "zoom"}
    }

