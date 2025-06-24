"""Quick auto-mix helper for prototyping."""

from __future__ import annotations

from typing import Dict
from pydub import AudioSegment


def provide_auto_mix(tracks: Dict[str, AudioSegment], out_file: str) -> str:
    """Mix ``tracks`` down and export to ``out_file``."""

    mixed = AudioSegment.silent(duration=0)
    for seg in tracks.values():
        mixed = mixed.overlay(seg)
    mixed.export(out_file, format="wav")
    return out_file


__all__ = ["provide_auto_mix"]
