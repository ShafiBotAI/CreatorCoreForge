"""Utilities for inline whisper effects."""

from __future__ import annotations

from pydub import AudioSegment


def inlinewhispersupport(
    segment: AudioSegment, start_ms: int, end_ms: int, reduction_db: float = 20.0
) -> AudioSegment:
    """Lower volume between ``start_ms`` and ``end_ms`` to mimic a whisper."""

    start_ms = max(0, start_ms)
    end_ms = min(len(segment), end_ms)
    quiet = segment[start_ms:end_ms] - reduction_db
    return segment[:start_ms] + quiet + segment[end_ms:]


__all__ = ["inlinewhispersupport"]
