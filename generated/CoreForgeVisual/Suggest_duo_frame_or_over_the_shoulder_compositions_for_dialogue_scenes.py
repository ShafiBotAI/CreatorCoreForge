# Auto-generated for Suggest duo-frame or over-the-shoulder compositions for dialogue scenes

from typing import Tuple

def suggest_duo_frame(characters: Tuple[str, str]) -> str:
    """Return a suggested camera composition for two characters."""
    if characters[0] == characters[1]:
        return "single-character"
    return "over-the-shoulder" if len(characters[0]) > len(characters[1]) else "duo-frame"
