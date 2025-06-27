# Auto-generated for NSFW mood heatmap analytics
"""Generate simple heatmaps for NSFW intensity over time."""

from __future__ import annotations


class NSFWHeatmap:
    def __init__(self) -> None:
        self.points: list[tuple[float, float]] = []  # (timestamp, intensity)

    def record(self, timestamp: float, intensity: float) -> None:
        self.points.append((timestamp, float(intensity)))

    def dataset(self) -> list[tuple[float, float]]:
        return sorted(self.points, key=lambda x: x[0])


__all__ = ["NSFWHeatmap"]
