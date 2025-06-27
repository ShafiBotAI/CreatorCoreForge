# Auto-generated for 3D spatial audio, binaural/ASMR modes, custom FX layering
"""Utility helpers for simple spatial audio effects."""

from __future__ import annotations

from typing import Iterable, Tuple
from pydub import AudioSegment


def spatialize_audio(input_file: str, positions: Iterable[Tuple[float, float]]) -> AudioSegment:
    """Pan ``input_file`` to sequential ``positions`` (left/right) in output."""

    audio = AudioSegment.from_file(input_file)
    output = AudioSegment.silent(duration=len(audio))
    segment_len = len(audio) // max(1, len(list(positions)))
    for i, (pan, _) in enumerate(positions):
        seg = audio[i * segment_len:(i + 1) * segment_len]
        seg = seg.pan(max(-1.0, min(1.0, pan)))
        output = output.overlay(seg, position=i * segment_len)
    return output


__all__ = ["spatialize_audio"]
