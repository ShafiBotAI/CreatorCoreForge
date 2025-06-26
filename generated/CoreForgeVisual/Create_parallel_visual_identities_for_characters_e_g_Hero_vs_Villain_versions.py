# Auto-generated for Create parallel visual identities for characters (e.g., Hero vs Villain versions)
from typing import Dict


def create_parallel_visual(name: str) -> Dict[str, str]:
    """Return hero and villain visual identifiers for a character."""
    return {
        "hero": f"{name}_hero.png",
        "villain": f"{name}_villain.png",
    }
