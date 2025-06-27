"""In-memory voice profile manager for CoreForge Audio."""
from __future__ import annotations
from dataclasses import dataclass
from pathlib import Path
from typing import Dict

from .VoicePersonalityProfiles import VoiceProfile

@dataclass
class StoredVoice:
    profile: VoiceProfile
    sample_path: Path

class VoiceManager:
    """Store voice profiles and map them to characters per book."""

    def __init__(self) -> None:
        self._voices: Dict[str, StoredVoice] = {}
        self._book_map: Dict[str, Dict[str, str]] = {}

    def upload_sample(self, character: str, sample_path: str) -> VoiceProfile:
        profile = VoiceProfile(name=character)
        self._voices[profile.name] = StoredVoice(profile, Path(sample_path))
        self.assign(profile, character, "global")
        return profile

    def assign(self, profile: VoiceProfile, character: str, book: str) -> None:
        self._book_map.setdefault(book, {})[character] = profile.name

    def voice_profile(self, character: str, book: str = "global") -> VoiceProfile | None:
        voice_name = self._book_map.get(book, {}).get(character)
        if voice_name:
            stored = self._voices.get(voice_name)
            return stored.profile if stored else None
        return None

__all__ = ["VoiceManager"]
