# Auto-generated for Auto-generate character design profiles from parsed book descriptions
from __future__ import annotations

from typing import Dict


def auto_generate_character(description: str) -> Dict[str, str]:
    """Return a simple profile extracted from ``description``."""

    words = description.lower().split()
    profile = {
        "name": words[0].capitalize() if words else "Unknown",
        "traits": ",".join(w for w in words[1:4])
    }
    return profile
