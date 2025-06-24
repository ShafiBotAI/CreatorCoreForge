"""Adjust the density of ambient layers within a scene."""
from __future__ import annotations

from pydub import AudioSegment


def scenedensitytuner(segment: AudioSegment, density: float) -> AudioSegment:
    """Increase density by overlaying the track when ``density`` > 1."""
    if density <= 1:
        return segment
    overlay = segment - 6
    return segment.overlay(overlay)


__all__ = ["scenedensitytuner"]
