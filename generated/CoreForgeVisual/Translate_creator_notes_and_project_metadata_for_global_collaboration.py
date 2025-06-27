# Auto-generated for Translate creator notes and project metadata for global collaboration
from __future__ import annotations

from typing import Dict


SIMPLE_TRANSLATIONS: Dict[str, Dict[str, str]] = {
    "es": {"hello": "hola", "world": "mundo"},
    "fr": {"hello": "bonjour", "world": "monde"},
}


def translate_creator_notes(text: str, target_lang: str) -> str:
    """Return a rudimentary translation for ``text`` into ``target_lang``.

    This is a placeholder implementation using a static dictionary.
    """

    lookup = SIMPLE_TRANSLATIONS.get(target_lang.lower(), {})
    return " ".join(lookup.get(word, word) for word in text.split())

