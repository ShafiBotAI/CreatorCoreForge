# Auto-generated for Persistent voice/scene memory, macro builder, team dashboard
from __future__ import annotations

from dataclasses import dataclass, field
from typing import List


@dataclass
class VoiceSceneDashboard:
    scenes: List[str] = field(default_factory=list)

    def add_scene(self, scene: str) -> None:
        self.scenes.append(scene)

    def list_scenes(self) -> List[str]:
        return list(self.scenes)


def persistent_voice_scene() -> VoiceSceneDashboard:
    """Return a :class:`VoiceSceneDashboard` tracker."""

    return VoiceSceneDashboard()


__all__ = ["VoiceSceneDashboard", "persistent_voice_scene"]
