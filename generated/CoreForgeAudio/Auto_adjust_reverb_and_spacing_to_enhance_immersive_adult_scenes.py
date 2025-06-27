# Auto-generated for Auto-adjust reverb and spacing to enhance immersive adult scenes
from __future__ import annotations

from pydub import AudioSegment


def auto_adjust_reverb(segment: AudioSegment, delay: int = 70, decay: float = 0.6) -> AudioSegment:
    """Return ``segment`` with a simple echo-based reverb effect applied."""
    if delay <= 0:
        return segment
    echo = segment[:0]
    attenuated = segment - (1.0 - decay) * 10
    echo = attenuated.overlay(segment, position=delay)
    return segment.overlay(echo)


__all__ = ["auto_adjust_reverb"]
