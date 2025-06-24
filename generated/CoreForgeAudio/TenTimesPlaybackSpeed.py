"""Utility to speed up audio playback by 10x."""
from __future__ import annotations

from pydub import AudioSegment


def tentimesplaybackspeed(audio: AudioSegment) -> AudioSegment:
    """Return ``audio`` played back ten times faster."""
    return audio.speedup(playback_speed=10.0)

__all__ = ["tentimesplaybackspeed"]
