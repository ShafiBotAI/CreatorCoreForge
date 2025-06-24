"""Modify playback speed based on voice pacing."""
from __future__ import annotations

from pydub import AudioSegment


def voiceawarepacing(segment: AudioSegment, rate: float) -> AudioSegment:
    """Return segment sped up (>1) or slowed down (<1) by ``rate``."""
    if rate <= 0:
        return segment
    new_rate = int(segment.frame_rate * rate)
    changed = segment._spawn(segment.raw_data, overrides={"frame_rate": new_rate})
    return changed.set_frame_rate(segment.frame_rate)


__all__ = ["voiceawarepacing"]
