# Auto-generated for Implement ambient crossfade logic between chapters and locations
"""Utility for seamless ambient transitions between chapters or locations."""

from __future__ import annotations

from pydub import AudioSegment


def implement_ambient_crossfade(
    current: AudioSegment,
    next_segment: AudioSegment,
    crossfade_ms: int = 1500,
) -> AudioSegment:
    """Return ``current`` followed by ``next_segment`` with a crossfade.

    Parameters
    ----------
    current: AudioSegment
        The currently playing ambience track.
    next_segment: AudioSegment
        The ambience track for the upcoming chapter/location.
    crossfade_ms: int, optional
        Duration of the crossfade in milliseconds. Defaults to ``1500``.

    Returns
    -------
    AudioSegment
        The combined audio ready for playback or export.
    """

    crossfade_ms = max(0, min(crossfade_ms, len(current), len(next_segment)))
    return current.append(next_segment, crossfade=crossfade_ms)


__all__ = ["implement_ambient_crossfade"]
