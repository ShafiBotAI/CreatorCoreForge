"""Utility to assign ramped emotion intensities to script segments."""
from __future__ import annotations

from typing import Iterable, List, Tuple


def ramp_emotions(segments: Iterable[str], start: float = 0.0, end: float = 1.0) -> List[Tuple[str, float]]:
    """Return ``segments`` paired with linearly ramped intensity values.

    Parameters
    ----------
    segments:
        Ordered text segments to apply emotion ramping.
    start:
        Starting intensity between 0 and 1.
    end:
        Ending intensity between 0 and 1.
    """
    seg_list = list(segments)
    if not seg_list:
        return []

    step = (end - start) / max(1, len(seg_list) - 1)
    ramped: List[Tuple[str, float]] = []
    for idx, seg in enumerate(seg_list):
        intensity = round(start + idx * step, 3)
        ramped.append((seg, intensity))
    return ramped


__all__ = ["ramp_emotions"]
