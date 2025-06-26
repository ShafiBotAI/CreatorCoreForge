# Auto-generated for GlobalLanguageSupport
"""Minimal translation lookup helper."""

from typing import Dict, List


_translations: Dict[str, Dict[str, str]] = {
    "es": {"hello": "hola"},
    "fr": {"hello": "bonjour"},
}


def translate(text: str, to: str) -> str:
    return _translations.get(to, {}).get(text, text)


def supported_languages() -> List[str]:
    return list(_translations.keys())


__all__ = ["translate", "supported_languages"]
