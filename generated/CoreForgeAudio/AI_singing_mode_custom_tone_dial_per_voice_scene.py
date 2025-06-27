# Auto-generated for AI singing mode, custom tone dial per voice/scene
"""Basic pitch-shift utility for a simple singing effect."""

from __future__ import annotations

from pathlib import Path
from pydub import AudioSegment


def ai_singing_mode(src: str, dst: str, semitone_shift: float = 0.0) -> str:
    """Apply a pitch shift to ``src`` and export to ``dst``.

    Parameters
    ----------
    src: str
        Path to the source WAV/MP3 file.
    dst: str
        Path where the processed file will be written.
    semitone_shift: float, optional
        Pitch change in semitones. Positive raises pitch, negative lowers it.
    """

    audio = AudioSegment.from_file(src)
    new_rate = int(audio.frame_rate * (2.0 ** (semitone_shift / 12.0)))
    shifted = audio._spawn(audio.raw_data, overrides={"frame_rate": new_rate})
    shifted = shifted.set_frame_rate(audio.frame_rate)
    Path(dst).parent.mkdir(parents=True, exist_ok=True)
    shifted.export(dst, format="wav")
    return dst


__all__ = ["ai_singing_mode"]
