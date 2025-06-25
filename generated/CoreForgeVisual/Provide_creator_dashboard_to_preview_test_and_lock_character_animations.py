# Auto-generated for Provide creator dashboard to preview, test, and lock character animations
from __future__ import annotations

from dataclasses import dataclass, field
from typing import List


@dataclass
class AnimationDashboard:
    animations: List[str] = field(default_factory=list)
    locked: List[str] = field(default_factory=list)

    def preview(self, animation: str) -> None:
        self.animations.append(animation)

    def lock(self, animation: str) -> None:
        if animation in self.animations and animation not in self.locked:
            self.locked.append(animation)

    def list_locked(self) -> List[str]:
        return list(self.locked)


def provide_creator_dashboard() -> AnimationDashboard:
    """Create and return an :class:`AnimationDashboard`."""

    return AnimationDashboard()


__all__ = ["AnimationDashboard", "provide_creator_dashboard"]
