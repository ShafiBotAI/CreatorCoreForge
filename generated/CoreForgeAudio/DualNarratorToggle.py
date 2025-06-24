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
