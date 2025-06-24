# Auto-generated for Persist character visuals across multiple books, including costume and evolution
from typing import Dict

_character_db: Dict[str, Dict[str, str]] = {}


def persist_character_visuals(character: str, attributes: Dict[str, str]) -> None:
    """Store or update character visual attributes."""

    _character_db.setdefault(character, {}).update(attributes)


def get_character_visuals(character: str) -> Dict[str, str]:
    """Retrieve stored attributes for a character."""

    return _character_db.get(character, {})
