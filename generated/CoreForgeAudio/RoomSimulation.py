"""Simulate simple room reverberation."""

from __future__ import annotations

from pydub import AudioSegment


def roomsimulation(
    segment: AudioSegment, delay_ms: int = 60, decay: float = 0.6, repeats: int = 2
) -> AudioSegment:
    """Overlay delayed echoes of ``segment`` to mimic a room."""

    out = segment
    for i in range(1, repeats + 1):
        echo = segment - (i * 10 * decay)
        out = out.overlay(echo, position=i * delay_ms)
    return out


__all__ = ["roomsimulation"]
