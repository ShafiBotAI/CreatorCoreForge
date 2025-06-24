
"""Utility for creating modified copies of voice DNA profiles."""

from __future__ import annotations
from typing import Dict, Any


def voicednaforking(
    base: Dict[str, Any], overrides: Dict[str, Any] | None = None
) -> Dict[str, Any]:
    """Return a new voice DNA based on ``base`` with ``overrides`` applied."""
    new_dna = base.copy()
    if overrides:
        new_dna.update(overrides)
    return new_dna
# Auto-generated for VoiceDNAForking
"""Create derivative voice profiles."""

from __future__ import annotations

from dataclasses import replace
from uuid import uuid4

from .VoicePersonalityProfiles import VoiceProfile


def voicednaforking(
    profile: VoiceProfile,
    pitch: float | None = None,
    rate: float | None = None,
    tone: str | None = None,
) -> VoiceProfile:
    """Return a new :class:`VoiceProfile` forked from ``profile``."""

    return replace(
        profile,
        name=f"{profile.name}_fork_{uuid4().hex[:8]}",
        pitch=pitch if pitch is not None else profile.pitch,
        rate=rate if rate is not None else profile.rate,
        tone=tone if tone is not None else profile.tone,
    )



__all__ = ["voicednaforking"]
