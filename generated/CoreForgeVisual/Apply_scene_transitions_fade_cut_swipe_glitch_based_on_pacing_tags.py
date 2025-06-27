# Auto-generated for Apply scene transitions (fade, cut, swipe, glitch) based on pacing tags
from __future__ import annotations

from typing import List


def apply_scene_transitions(pacing_tags: List[str]) -> List[str]:
    """Return a list of transitions matching ``pacing_tags``."""

    mapping = {
        "slow": "fade",
        "normal": "cut",
        "fast": "swipe",
        "chaotic": "glitch",
    }
    return [mapping.get(tag, "cut") for tag in pacing_tags]
