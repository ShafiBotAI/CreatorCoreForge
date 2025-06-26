# Auto-generated for Drag-and-drop scene, shot, and effect editor
"""Basic timeline helper for drag-and-drop actions."""

from typing import Iterable, List


def drag_and_drop(items: Iterable[str]) -> List[str]:
    """Return a timeline list based on ``items`` order."""

    timeline = []
    for item in items:
        timeline.append(f"drop:{item}")
    return timeline


__all__ = ["drag_and_drop"]
