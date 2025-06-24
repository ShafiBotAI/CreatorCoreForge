"""Export helper for flattened or layered audio."""

from __future__ import annotations

from typing import Dict
from pathlib import Path
from pydub import AudioSegment


def export_final_audio(
    tracks: Dict[str, AudioSegment], out_file: str, *, layered: bool = False
) -> str:
    """Export ``tracks`` to ``out_file`` in layered or flattened form."""

    if layered:
        out_dir = Path(out_file)
        out_dir.mkdir(parents=True, exist_ok=True)
        for name, seg in tracks.items():
            seg.export(out_dir / f"{name}.wav", format="wav")
        return str(out_dir)

    mixed = AudioSegment.silent(duration=0)
    for seg in tracks.values():
        mixed = mixed.overlay(seg)
    mixed.export(out_file, format="wav")
    return out_file


__all__ = ["export_final_audio"]
