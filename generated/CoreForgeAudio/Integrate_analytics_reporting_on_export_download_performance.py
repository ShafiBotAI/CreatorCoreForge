# Auto-generated for Integrate analytics reporting on export/download performance
"""Collect analytics for export/download operations."""

from __future__ import annotations


class ExportAnalytics:
    def __init__(self) -> None:
        self.records: list[dict[str, float]] = []

    def record_export(self, size: int, duration: float) -> None:
        self.records.append({"size": float(size), "duration": duration})

    def summary(self) -> dict[str, float]:
        count = len(self.records)
        if not count:
            return {"count": 0, "avg_size": 0.0, "avg_duration": 0.0}
        avg_size = sum(r["size"] for r in self.records) / count
        avg_duration = sum(r["duration"] for r in self.records) / count
        return {"count": count, "avg_size": avg_size, "avg_duration": avg_duration}


__all__ = ["ExportAnalytics"]
