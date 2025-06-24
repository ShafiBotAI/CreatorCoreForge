"""Utilities for altering speech cadence."""

from __future__ import annotations

from pydub import AudioSegment


def cadencemodulation(segment: AudioSegment, rate: float) -> AudioSegment:
    """Return ``segment`` with playback speed adjusted by ``rate``.

    Parameters
    ----------
    segment:
        Input audio data.
    rate:
        Playback rate multiplier where ``1.0`` is original speed.
    """

    if rate <= 0:
        raise ValueError("rate must be positive")

    new_rate = int(segment.frame_rate * rate)
    altered = segment._spawn(segment.raw_data, overrides={"frame_rate": new_rate})
    return altered.set_frame_rate(segment.frame_rate)


__all__ = ["cadencemodulation"]
