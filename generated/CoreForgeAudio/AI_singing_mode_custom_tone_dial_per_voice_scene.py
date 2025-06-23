# Auto-generated for AI singing mode, custom tone dial per voice/scene
from __future__ import annotations

from typing import Iterable, List


def apply_singing_tone(samples: Iterable[float], tone: float) -> List[float]:
    """Apply a simple tone multiplier to audio sample amplitudes."""

    tone = max(0.5, min(tone, 2.0))
    return [max(min(s * tone, 1.0), -1.0) for s in samples]


__all__ = ["apply_singing_tone"]
