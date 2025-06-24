"""Simple heuristics for narration performance suggestions."""

from __future__ import annotations

from typing import Dict, List


def ai_based_performance(metrics: Dict[str, float]) -> List[str]:
    """Return enhancement tips based on ``metrics`` values."""

    suggestions: List[str] = []
    if metrics.get("pitch_variance", 1.0) < 0.1:
        suggestions.append("Increase pitch variation for expressiveness.")
    if metrics.get("speaking_rate", 1.0) > 1.5:
        suggestions.append("Consider slowing down for clarity.")
    if metrics.get("noise_level", 0.0) > 0.05:
        suggestions.append("Reduce background noise for cleaner audio.")
    return suggestions


__all__ = ["ai_based_performance"]
