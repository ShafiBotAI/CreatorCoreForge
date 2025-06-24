# Auto-generated for Allow adaptive tone matching when character enters new genres/settings
from typing import Dict


GENRE_TONES: Dict[str, str] = {
    "horror": "whisper",
    "fantasy": "dramatic",
    "sci-fi": "neutral",
    "romance": "warm",
}


def allow_adaptive_tone(genre: str) -> str:
    """Return suggested tone for a given genre."""
    return GENRE_TONES.get(genre.lower(), "neutral")
