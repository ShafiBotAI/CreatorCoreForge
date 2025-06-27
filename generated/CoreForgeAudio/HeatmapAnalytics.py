# Auto-generated for HeatmapAnalytics
"""Basic waveform heatmap utilities."""

from __future__ import annotations

from pydub import AudioSegment


def amplitude_heatmap(segment: AudioSegment, bucket_ms: int = 1000) -> list[float]:
    """Return RMS amplitude for consecutive ``bucket_ms`` windows of ``segment``.

    The values are normalized to the range 0-1 for easy visualization.
    """

    if bucket_ms <= 0:
        bucket_ms = 1000

    samples_per_bucket = bucket_ms * segment.frame_rate // 1000
    heat = []
    for start in range(0, len(segment), bucket_ms):
        chunk = segment[start : start + bucket_ms]
        rms = chunk.rms
        heat.append(rms / 32768.0)
    return heat


__all__ = ["amplitude_heatmap"]
