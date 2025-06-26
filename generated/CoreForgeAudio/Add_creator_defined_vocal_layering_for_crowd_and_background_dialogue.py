# Auto-generated for Add creator-defined vocal layering for crowd and background dialogue
from __future__ import annotations

from typing import Dict, Iterable
from pydub import AudioSegment


def add_creator_defined(base: AudioSegment, layers: Iterable[AudioSegment]) -> AudioSegment:
    """Return ``base`` mixed with all ``layers``."""

    output = base
    for layer in layers:
        output = output.overlay(layer)
    return output


__all__ = ["add_creator_defined"]
