# Auto-generated for UnifiedAudioEngine
"""Minimal shared audio engine utilities."""

class UnifiedAudioEngine:
    """Provide global volume and mute control."""

    def __init__(self) -> None:
        self._volume = 1.0
        self._muted = False

    def set_volume(self, value: float) -> None:
        """Clamp and store global volume between 0 and 1."""
        self._volume = max(0.0, min(1.0, value))

    def current_volume(self) -> float:
        return self._volume

    def fade_volume(self, target: float, steps: int = 10) -> list[float]:
        """Return intermediate volumes while fading to ``target``."""
        target = max(0.0, min(1.0, target))
        if steps <= 0:
            self.set_volume(target)
            return [self._volume]
        start = self._volume
        delta = (target - start) / steps
        levels = []
        for i in range(1, steps + 1):
            self.set_volume(start + delta * i)
            levels.append(self._volume)
        return levels

    def mute(self) -> None:
        self._muted = True

    def unmute(self) -> None:
        self._muted = False

    @property
    def is_muted(self) -> bool:
        return self._muted


__all__ = ["UnifiedAudioEngine"]
