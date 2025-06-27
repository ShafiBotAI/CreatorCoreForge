# Auto-generated for Quality metrics and tuning controls
"""Helpers for measuring audio quality."""

from __future__ import annotations

from pydub import AudioSegment


def loudness_dbfs(segment: AudioSegment) -> float:
    """Return the average loudness in decibels relative to full scale."""
    return float(segment.dBFS)


def signal_to_noise(reference: AudioSegment, noise: AudioSegment) -> float:
    """Compute a simple SNR ratio in decibels."""

    ref_samples = reference.get_array_of_samples()
    noise_samples = noise.get_array_of_samples()
    if len(noise_samples) == 0:
        return float("inf")
    ref_power = sum(float(x) ** 2 for x in ref_samples) / len(ref_samples)
    noise_power = sum(float(x) ** 2 for x in noise_samples) / len(noise_samples)
    if noise_power == 0:
        return float("inf")
    import math

    return 10 * math.log10(ref_power / noise_power)


__all__ = ["loudness_dbfs", "signal_to_noise"]
