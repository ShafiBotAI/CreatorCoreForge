# Auto-generated for Create a full-cast preview mode with toggles for each voice track
from __future__ import annotations

from typing import Dict, Iterable
from pydub import AudioSegment


def create_a_full(tracks: Dict[str, AudioSegment], enabled: Iterable[str]) -> AudioSegment:
    """Mix tracks marked in ``enabled`` for preview."""

    mix = AudioSegment.silent(duration=0)
    for name in enabled:
        seg = tracks.get(name)
        if seg:
            mix = mix.overlay(seg)
    return mix


__all__ = ["create_a_full"]
