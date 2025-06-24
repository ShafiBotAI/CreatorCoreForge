"""Stereo panning utilities."""

from __future__ import annotations

from pydub import AudioSegment


def spatialpositioning(segment: AudioSegment, pan: float = 0.0) -> AudioSegment:
    """Return ``segment`` panned left (-1.0) to right (1.0)."""

    return segment.pan(pan)


__all__ = ["spatialpositioning"]
