# Auto-generated for AccentGenerator
from __future__ import annotations

from typing import Dict


def accent_generator(text: str, accent: str) -> str:
    """Return ``text`` transformed with a simple accent effect."""

    rules: Dict[str, Dict[str, str]] = {
        "pirate": {"you": "ye", "my": "me", "is": "be"},
        "french": {"th": "z", "h": ""},
    }

    mapping = rules.get(accent.lower())
    if not mapping:
        return text
    for src, repl in mapping.items():
        text = text.replace(src, repl)
    return text


__all__ = ["accent_generator"]
