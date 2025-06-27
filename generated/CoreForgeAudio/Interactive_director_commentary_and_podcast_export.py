# Auto-generated for Interactive director commentary and podcast export
"""Utilities for adding director commentary to an audio track."""

from __future__ import annotations

from pydub import AudioSegment


def export_with_commentary(
    audio: AudioSegment,
    commentary: AudioSegment,
    output_path: str,
    *,
    crossfade_ms: int = 1000,
) -> str:
    """Overlay ``commentary`` onto ``audio`` and export to ``output_path``.

    Commentary volume is lowered slightly and mixed at the start of the track.
    ``crossfade_ms`` controls the fade between commentary and the main audio.
    The resulting file is exported in WAV format and the path is returned.
    """

    if crossfade_ms < 0:
        crossfade_ms = 0

    combined = audio.overlay(commentary - 6, position=0, gain_during_overlay=-3)
    combined = combined.fade_in(crossfade_ms)
    combined.export(output_path, format="wav")
    return output_path


__all__ = ["export_with_commentary"]
