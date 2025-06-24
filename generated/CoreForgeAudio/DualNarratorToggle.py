
"""Utility to toggle between two narrator identifiers."""

from __future__ import annotations


def dualnarratortoggle(current: str, narrator_a: str, narrator_b: str) -> str:
    """Return the alternate narrator given ``current``."""
    return narrator_b if current == narrator_a else narrator_a
=======
# Auto-generated for DualNarratorToggle
"""Toggle overlay of a secondary narrator track."""

from __future__ import annotations

from pydub import AudioSegment


def dualnarratortoggle(
    primary: AudioSegment,
    secondary: AudioSegment,
    enabled: bool = False,
    secondary_db: float = -6.0,
) -> AudioSegment:
    """Return combined narration if ``enabled`` else ``primary``.

    Parameters
    ----------
    primary:
        Main narration segment.
    secondary:
        Secondary narration segment.
    enabled:
        If ``True``, overlay ``secondary`` onto ``primary``.
    secondary_db:
        Volume adjustment for ``secondary`` in dB.
    """

    if not enabled:
        return primary
    return primary.overlay(secondary + secondary_db)



__all__ = ["dualnarratortoggle"]
