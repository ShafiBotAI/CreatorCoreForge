# Auto-generated for Enable AI suggestions for retiming scene flow or voice cadence
from __future__ import annotations

from typing import List


def enable_ai_suggestions(timestamps: List[float]) -> List[float]:
    """Return pacing suggestions based on average spacing of ``timestamps``."""

    if len(timestamps) < 2:
        return timestamps
    avg_gap = (timestamps[-1] - timestamps[0]) / float(len(timestamps) - 1)
    return [timestamps[0] + i * avg_gap for i in range(len(timestamps))]
