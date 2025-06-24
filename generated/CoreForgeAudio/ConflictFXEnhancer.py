"""Enhance scenes with conflict using noise overlays."""
from __future__ import annotations

from pydub import AudioSegment
from pydub.generators import WhiteNoise


def conflictfxenhancer(segment: AudioSegment, intensity: float = 0.5) -> AudioSegment:
    """Overlay subtle noise based on ``intensity``."""
    intensity = max(0.0, min(1.0, intensity))
    noise = WhiteNoise().to_audio_segment(duration=len(segment)) - (10 * (1 - intensity))
    return segment.overlay(noise)


__all__ = ["conflictfxenhancer"]
