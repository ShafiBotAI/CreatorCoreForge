"""Manage a glossary of visual cues with multilingual descriptions."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List

@dataclass
class VisualCue:
    cue: str
    translations: Dict[str, str]
    example: str


class VisualCueGlossary:
    def __init__(self) -> None:
        self._cues: List[VisualCue] = []

    def add_cue(self, cue: str, translations: Dict[str, str], example: str) -> None:
        self._cues.append(VisualCue(cue, translations, example))

    def lookup(self, cue: str, lang: str) -> str | None:
        for item in self._cues:
            if item.cue == cue:
                return item.translations.get(lang, item.example)
        return None
