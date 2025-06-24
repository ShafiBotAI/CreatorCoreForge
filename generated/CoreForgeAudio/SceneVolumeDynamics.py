"""Utilities for simple scene volume dynamics."""

from __future__ import annotations

from pydub import AudioSegment


def scenevolumedynamics(
    segment: AudioSegment, fade_in_ms: int = 0, fade_out_ms: int = 0
) -> AudioSegment:
    """Apply fade in and fade out to ``segment``."""

    return segment.fade_in(fade_in_ms).fade_out(fade_out_ms)


__all__ = ["scenevolumedynamics"]
