# Auto-generated for AudioEffectsPipeline
from __future__ import annotations

from pathlib import Path
from typing import Iterable

from pydub import AudioSegment


def audioeffectspipeline(inputs: Iterable[Path], output: Path) -> Path:
    """Mix ``inputs`` together and export to ``output``."""

    combined = AudioSegment.silent(duration=0)
    for path in inputs:
        combined = combined.overlay(AudioSegment.from_file(path))
    combined.export(output, format=output.suffix.lstrip("."))
    return output
