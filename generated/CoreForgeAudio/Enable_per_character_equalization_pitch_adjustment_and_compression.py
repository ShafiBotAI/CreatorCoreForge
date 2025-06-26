# Auto-generated for Enable per-character equalization, pitch adjustment, and compression
from __future__ import annotations

from typing import Dict
from pydub import AudioSegment, effects


def enable_per_character(
    tracks: Dict[str, AudioSegment],
    eq_gain_db: float = 0.0,
    pitch_factor: float = 1.0,
    *,
    compress: bool = False,
) -> Dict[str, AudioSegment]:
    """Return ``tracks`` with simple EQ, pitch, and compression applied."""

    processed: Dict[str, AudioSegment] = {}
    for name, seg in tracks.items():
        out = seg.apply_gain(eq_gain_db)
        if pitch_factor != 1.0:
            shifted = out._spawn(
                out.raw_data,
                overrides={"frame_rate": int(out.frame_rate * pitch_factor)},
            )
            out = shifted.set_frame_rate(seg.frame_rate)
        if compress:
            out = effects.compress_dynamic_range(out)
        processed[name] = out

    return processed


__all__ = ["enable_per_character"]
