"""Compute simple dominance metrics for voices."""

from __future__ import annotations

from typing import Dict


def visualize_voice_dominance(chapter_stats: Dict[str, int]) -> Dict[str, float]:
    """Return percentage dominance for each voice in ``chapter_stats``."""

    total = sum(chapter_stats.values()) or 1
    return {k: (v / total) * 100.0 for k, v in chapter_stats.items()}


__all__ = ["visualize_voice_dominance"]
