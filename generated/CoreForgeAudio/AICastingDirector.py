# Auto-generated for AICastingDirector
"""Simple casting helper for CoreForge Audio."""

from __future__ import annotations

from typing import Dict, Iterable

_DEFAULT_CAST: Dict[str, str] = {
    "hero": "EpicBaritone",
    "villain": "DarkWhisper",
    "narrator": "WarmStoryteller",
}


def aicastingdirector(characters: Iterable[str], preferences: Dict[str, str] | None = None) -> Dict[str, str]:
    """Return a mapping of characters to voice profiles.

    Parameters
    ----------
    characters:
        Iterable of character names.
    preferences:
        Optional override mapping provided by the creator.
    """

    cast: Dict[str, str] = {}
    for char in characters:
        key = char.lower()
        if preferences and char in preferences:
            cast[char] = preferences[char]
        else:
            cast[char] = _DEFAULT_CAST.get(key, "StandardVoice")
    return cast


__all__ = ["aicastingdirector"]
