"""Basic checker for consistent audio volume between segments."""
from __future__ import annotations

from typing import Iterable
from pydub import AudioSegment


def toneconsistencychecker(segments: Iterable[AudioSegment], threshold: float = 3.0) -> bool:
    """Return ``True`` if volume difference <= ``threshold`` dB."""
    levels = [s.dBFS for s in segments if len(s) > 0]
    if not levels:
        return True
    return max(levels) - min(levels) <= threshold


__all__ = ["toneconsistencychecker"]
