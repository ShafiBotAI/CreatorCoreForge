# Auto-generated for Support "multiverse collapse" audio effect when timelines converge
"""Utilities to merge two timelines with a collapse transition."""

from __future__ import annotations

from pydub import AudioSegment


def support_multiverse_collapse(
    path_a: str, path_b: str, out_path: str, duration_ms: int = 3000,
    out_format: str = "wav"
) -> str:
    """Combine two audio files with a crossfade collapse effect.

    Parameters
    ----------
    path_a: str
        First timeline audio file.
    path_b: str
        Second timeline audio file.
    out_path: str
        Destination path for the collapsed mix.
    duration_ms: int
        Crossfade duration in milliseconds.

    Returns
    -------
    str
        The output path for chaining.
    """

    track_a = AudioSegment.from_file(path_a)
    track_b = AudioSegment.from_file(path_b)
    collapsed = track_a.append(track_b, crossfade=duration_ms)
    collapsed.export(out_path, format=out_format)
    return out_path


__all__ = ["support_multiverse_collapse"]
