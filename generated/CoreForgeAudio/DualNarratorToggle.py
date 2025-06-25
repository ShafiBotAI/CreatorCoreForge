"""Toggle overlay of a secondary narrator track."""

from __future__ import annotations

from pydub import AudioSegment

__all__ = ["dualnarratortoggle"]

def dualnarratortoggle(
    primary: AudioSegment,
    secondary: AudioSegment,
    enabled: bool = False,
    secondary_db: float = -6.0,
) -> AudioSegment:
    """Return combined narration if ``enabled`` else ``primary``."""
    if not enabled:
        return primary
    return primary.overlay(secondary + secondary_db)
