"""Simple shared audio engine for CoreForge apps."""
from __future__ import annotations
from typing import List

class UnifiedAudioEngine:
    """Manage global volume and mute state with fade transitions."""

    _instance: "UnifiedAudioEngine" | None = None

    def __init__(self) -> None:
        self._volume = 1.0
        self._muted = False

    @classmethod
    def shared(cls) -> "UnifiedAudioEngine":
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def set_volume(self, value: float) -> None:
        self._volume = max(0.0, min(1.0, value))

    def current_volume(self) -> float:
        return 0.0 if self._muted else self._volume

    def mute(self) -> None:
        self._muted = True

    def unmute(self) -> None:
        self._muted = False

    def is_muted(self) -> bool:
        return self._muted

    def fade_volume_to(self, target: float, steps: int = 10) -> List[float]:
        """Gradually adjust volume to ``target`` and return each level."""
        target = max(0.0, min(1.0, target))
        if steps <= 0:
            self.set_volume(target)
            return [self.current_volume()]
        start = self._volume
        delta = (target - start) / steps
        levels: List[float] = []
        for _ in range(steps):
            self.set_volume(self._volume + delta)
            levels.append(self.current_volume())
        return levels

__all__ = ["UnifiedAudioEngine"]
