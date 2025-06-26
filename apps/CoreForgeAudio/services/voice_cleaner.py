"""Utilities for cleaning and normalizing voice samples.

This module is inspired by the `voice_extractor` class used in the
`ebook2audiobook` project. It converts an arbitrary audio file into a
mono WAV file, trims silence, and applies loudness normalization so the
resulting sample is ready for voice training or audiobook generation.
"""

from __future__ import annotations

import os
import subprocess
from typing import Optional

from pydub import AudioSegment
from shutil import which


def _run_ffmpeg(cmd: list[str]) -> None:
    """Run an ffmpeg command and raise ``RuntimeError`` on failure."""
    if not which(cmd[0]):
        raise FileNotFoundError(cmd[0])
    process = subprocess.run(cmd, capture_output=True, text=True)
    if process.returncode != 0:
        raise RuntimeError(process.stderr.strip())


def clean_voice_sample(input_file: str, output_dir: str, sample_rate: int = 24000) -> str:
    """Return path to a cleaned WAV file derived from ``input_file``.

    Parameters
    ----------
    input_file: str
        Path to the original recording.
    output_dir: str
        Directory where the cleaned file will be written.
    sample_rate: int, optional
        Target sample rate of the output audio. Defaults to ``24000``.
    """
    os.makedirs(output_dir, exist_ok=True)
    tmp_wav = os.path.join(output_dir, "_tmp.wav")

    # convert to mono wav so pydub can process it uniformly
    _run_ffmpeg([
        "ffmpeg", "-hide_banner", "-nostats",
        "-i", input_file,
        "-ac", "1",
        "-y", tmp_wav,
    ])

    # remove short silences
    audio = AudioSegment.from_file(tmp_wav)
    processed = AudioSegment.silent(duration=0)
    threshold = -60
    for chunk in audio[::100]:
        if chunk.dBFS > threshold:
            processed += chunk

    processed = processed.set_frame_rate(sample_rate)
    cleaned_path = os.path.join(output_dir, "voice_clean.wav")
    processed.export(cleaned_path, format="wav")

    # loudness normalization for consistent quality
    _run_ffmpeg([
        "ffmpeg", "-hide_banner", "-nostats",
        "-i", cleaned_path,
        "-af", "loudnorm=I=-14:TP=-3:LRA=7",
        "-ar", str(sample_rate),
        "-y", cleaned_path,
    ])

    os.remove(tmp_wav)
    return cleaned_path

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Clean a voice sample for training")
    parser.add_argument("input", help="Path to the source audio file")
    parser.add_argument("-o", "--output", default="voice_output", help="Directory for cleaned file")
    parser.add_argument("-r", "--rate", type=int, default=24000, help="Output sample rate")
    args = parser.parse_args()

    out = clean_voice_sample(args.input, args.output, args.rate)
    print(f"Cleaned voice saved to {out}")
