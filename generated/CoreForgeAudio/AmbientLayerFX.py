"""Utilities for layering ambient effects onto a base track."""
from __future__ import annotations

from typing import Iterable
from pydub import AudioSegment


def ambientlayerfx(base: AudioSegment, layers: Iterable[AudioSegment], volumes: Iterable[float] | None = None) -> AudioSegment:
    """Overlay ``layers`` on ``base`` adjusting each by ``volumes`` in dB."""
    if volumes is None:
        volumes = [0.0 for _ in layers]
    out = base
    for layer, vol in zip(layers, volumes):
        out = out.overlay(layer + vol)
    return out


__all__ = ["ambientlayerfx"]
