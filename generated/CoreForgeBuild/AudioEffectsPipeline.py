# Auto-generated for AudioEffectsPipeline
"""Utility helpers for audio sample manipulation."""

from typing import List


class AudioEffectsPipeline:
    def add_echo(self, samples: List[str]) -> List[str]:
        return [s for item in samples for s in (item, f"{item}-echo")]

    def shift_pitch(self, samples: List[str], factor: float) -> List[str]:
        return [f"{s}|pitch:{factor}" for s in samples]

    def mix(self, samples: List[str]) -> str:
        return "+".join(samples)


__all__ = ["AudioEffectsPipeline"]
