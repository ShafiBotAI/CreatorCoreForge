# Auto-generated for AdaptiveMusicGenerator
"""Generate background music layers based on mood and intensity."""

from __future__ import annotations

from typing import List
import random


def adaptivemusicgenerator(mood: str, intensity: float) -> List[str]:
    """Return a list of audio track names for the scene."""

    base_tracks = {
        "calm": ["pads.wav", "soft_piano.wav"],
        "tense": ["strings_tense.wav", "drone_low.wav"],
        "happy": ["guitar_happy.wav", "bells.wav"],
    }

    tracks = list(base_tracks.get(mood, ["default.wav"]))
    if intensity > 0.5:
        tracks.append("percussion_heavy.wav")
    random.shuffle(tracks)
    return tracks


__all__ = ["adaptivemusicgenerator"]
