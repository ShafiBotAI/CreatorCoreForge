"""Generate a simple stutter or laugh effect from a segment."""

from __future__ import annotations

from pydub import AudioSegment


def stutterlaughgenerator(
    segment: AudioSegment, syllable_ms: int = 80, repetitions: int = 2
) -> AudioSegment:
    """Prepend ``segment`` with a stuttered slice to simulate a laugh."""

    slice_ = segment[:syllable_ms]
    stutter = slice_ * repetitions
    return stutter + segment


__all__ = ["stutterlaughgenerator"]
