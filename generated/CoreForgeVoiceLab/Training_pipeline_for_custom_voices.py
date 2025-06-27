# Auto-generated for Training pipeline for custom voices
"""Simplified data preparation pipeline for custom voice models."""

from __future__ import annotations

import os
from dataclasses import dataclass
from typing import Dict

from pydub import AudioSegment


@dataclass
class TrainingStats:
    files: int = 0
    duration: float = 0.0


def prepare_dataset(source_dir: str, dest_dir: str, sample_rate: int = 16000) -> TrainingStats:
    """Convert WAV files in ``source_dir`` to ``sample_rate`` and store in ``dest_dir``.

    Returns basic statistics describing the processed dataset.
    """

    stats = TrainingStats()
    os.makedirs(dest_dir, exist_ok=True)

    for name in os.listdir(source_dir):
        if not name.lower().endswith(".wav"):
            continue
        src = os.path.join(source_dir, name)
        audio = AudioSegment.from_file(src)
        audio = audio.set_frame_rate(sample_rate).set_channels(1)
        stats.duration += audio.duration_seconds
        dst = os.path.join(dest_dir, f"{stats.files:04d}.wav")
        audio.export(dst, format="wav")
        stats.files += 1

    return stats


__all__ = ["prepare_dataset", "TrainingStats"]
