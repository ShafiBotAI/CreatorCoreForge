# Auto-generated for Store FX template libraries per genre for reuse
from typing import Dict, List

_fx_library: Dict[str, List[str]] = {}


def store_fx_template(genre: str, fx_list: List[str]) -> None:
    """Store or extend FX templates for a genre."""

    existing = _fx_library.setdefault(genre.lower(), [])
    for fx in fx_list:
        if fx not in existing:
            existing.append(fx)


def get_fx_templates(genre: str) -> List[str]:
    """Return stored FX templates for a genre."""

    return _fx_library.get(genre.lower(), [])
