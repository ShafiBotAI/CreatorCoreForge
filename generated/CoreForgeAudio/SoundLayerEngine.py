"""Overlay multiple audio layers into a single mix."""
from __future__ import annotations

from typing import Iterable

from pydub import AudioSegment


def soundlayerengine(layers: Iterable[AudioSegment]) -> AudioSegment:
    """Combine ``layers`` by overlaying them in order."""
    layer_list = list(layers)
    if not layer_list:
        return AudioSegment.silent(duration=0)

    mix = layer_list[0]
    for seg in layer_list[1:]:
        mix = mix.overlay(seg)
    return mix

__all__ = ["soundlayerengine"]
