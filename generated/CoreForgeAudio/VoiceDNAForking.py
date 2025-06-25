"""Create derivative voice profiles."""

from __future__ import annotations

from dataclasses import replace
from uuid import uuid4

from .VoicePersonalityProfiles import VoiceProfile

__all__ = ["voicednaforking"]

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
