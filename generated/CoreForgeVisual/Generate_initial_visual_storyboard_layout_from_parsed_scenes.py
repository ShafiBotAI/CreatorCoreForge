# Auto-generated for Generate initial visual storyboard layout from parsed scenes
from __future__ import annotations

from dataclasses import dataclass
from typing import List


@dataclass
class StoryboardFrame:
    scene: str
    start: float
    duration: float


def generate_initial_visual(scenes: List[str], default_duration: float = 5.0) -> List[StoryboardFrame]:
    """Create a simple linear storyboard from ``scenes``."""

    frames: List[StoryboardFrame] = []
    current = 0.0
    for scene in scenes:
        frames.append(StoryboardFrame(scene=scene, start=current, duration=default_duration))
        current += default_duration
    return frames
