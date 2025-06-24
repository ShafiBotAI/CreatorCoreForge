"""Manage voice personality profiles for character narration."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List


@dataclass
class VoiceProfile:
    """Configuration describing a voice personality."""

    name: str
    pitch: float = 1.0
    rate: float = 1.0
    tone: str = "neutral"


class VoicePersonalityProfiles:
    """Store and retrieve :class:`VoiceProfile` instances."""

    def __init__(self) -> None:
        self._profiles: Dict[str, VoiceProfile] = {}

    def add_profile(self, profile: VoiceProfile) -> None:
        """Register ``profile`` under its name."""
        self._profiles[profile.name] = profile

    def get_profile(self, name: str) -> VoiceProfile | None:
        """Return the profile identified by ``name`` or ``None``."""
        return self._profiles.get(name)

    def list_profiles(self) -> List[VoiceProfile]:
        """Return all stored profiles."""
        return list(self._profiles.values())


__all__ = ["VoiceProfile", "VoicePersonalityProfiles"]
