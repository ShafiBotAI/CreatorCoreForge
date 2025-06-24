"""Apply a pitch shift mid-sentence."""

from __future__ import annotations

from pydub import AudioSegment


def midsentencetoneswitching(
    segment: AudioSegment, switch_ms: int, rate: float
) -> AudioSegment:
    """Change the pitch of ``segment`` after ``switch_ms`` by ``rate``."""

    switch_ms = max(0, min(len(segment), switch_ms))
    part1 = segment[:switch_ms]
    part2 = segment[switch_ms:]
    new_rate = int(part2.frame_rate * rate)
    shifted = part2._spawn(part2.raw_data, overrides={"frame_rate": new_rate})
    shifted = shifted.set_frame_rate(part2.frame_rate)
    return part1 + shifted


__all__ = ["midsentencetoneswitching"]
