# Auto-generated for Simulate stereo spatial positioning per voice (left/right, near/far)
from __future__ import annotations

from typing import Dict
from pydub import AudioSegment


def simulate_stereo_spatial(tracks: Dict[str, AudioSegment], pan_values: Dict[str, float]) -> Dict[str, AudioSegment]:
    """Return tracks panned to their desired left/right position."""

    output: Dict[str, AudioSegment] = {}
    for name, seg in tracks.items():
        pan = pan_values.get(name, 0.0)
        output[name] = seg.pan(max(-1.0, min(1.0, pan)))
    return output


__all__ = ["simulate_stereo_spatial"]
