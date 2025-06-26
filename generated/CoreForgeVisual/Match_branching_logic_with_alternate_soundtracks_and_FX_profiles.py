# Auto-generated for Match branching logic with alternate soundtracks and FX profiles
from typing import Dict

_profiles: Dict[str, str] = {
    "heroic": "soundtrack_hero.mp3",
    "dark": "soundtrack_dark.mp3",
    "romance": "soundtrack_romance.mp3",
}


def match_branching_logic(branch: str) -> str:
    """Return soundtrack profile for a given story branch."""
    return _profiles.get(branch.lower(), "soundtrack_default.mp3")
