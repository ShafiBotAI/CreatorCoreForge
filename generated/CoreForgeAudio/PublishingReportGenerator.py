"""Generate summary reports for published audiobooks."""
from __future__ import annotations

import os
from typing import Dict

import wave


def generate_report(audio_path: str, metadata: Dict[str, str]) -> Dict[str, str]:
    """Return a simple report with duration and file size."""
    with wave.open(audio_path, "rb") as wf:
        frames = wf.getnframes()
        rate = wf.getframerate()
        duration = frames / float(rate)
    report = {
        "duration_seconds": max(1, int(round(duration))),
        "size_bytes": os.path.getsize(audio_path),
    }
    report.update(metadata)
    return report


__all__ = ["generate_report"]
