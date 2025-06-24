# Auto-generated for Trigger visual filters (noir, dream, sepia, neon) based on scene metadata
from typing import List


def trigger_visual_filters(scene_tags: List[str]) -> str:
    """Select a visual filter based on scene metadata tags."""

    for tag in scene_tags:
        lowered = tag.lower()
        if "noir" in lowered:
            return "noir"
        if "dream" in lowered:
            return "dream"
        if "sepia" in lowered:
            return "sepia"
        if "neon" in lowered:
            return "neon"
    return "none"
