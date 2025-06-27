# Auto-generated for Allow lip sync intensity control and timing nudge tools
from __future__ import annotations

from typing import List


def allow_lip_sync(phoneme_times: List[float], intensity: float) -> List[float]:
    """Return adjusted timings scaled by ``intensity``."""

    return [t * intensity for t in phoneme_times]
