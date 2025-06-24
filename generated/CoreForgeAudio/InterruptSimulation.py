"""Insert silent breaks into a voice segment to mimic interruptions."""

from __future__ import annotations

from typing import Iterable

from pydub import AudioSegment


def interruptsimulation(
    segment: AudioSegment, positions: Iterable[int], silence_ms: int = 200
) -> AudioSegment:
    """Return ``segment`` with silence inserted at ``positions``.

    Parameters
    ----------
    segment:
        Audio to modify.
    positions:
        Millisecond offsets where silence should be inserted.
    silence_ms:
        Duration of each inserted silent portion.
    """

    positions_sorted = sorted(int(p) for p in positions)
    out = AudioSegment.empty()
    last = 0
    for pos in positions_sorted:
        out += segment[last:pos]
        out += AudioSegment.silent(duration=silence_ms)
        last = pos
    out += segment[last:]
    return out


__all__ = ["interruptsimulation"]
