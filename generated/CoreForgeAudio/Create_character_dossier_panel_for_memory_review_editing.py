# Auto-generated for Create character dossier panel for memory review/editing
"""Basic model for storing character dossiers."""

from __future__ import annotations


class CharacterDossier:
    def __init__(self, name: str, description: str = "") -> None:
        self.name = name
        self.description = description
        self.notes: list[str] = []

    def add_note(self, text: str) -> None:
        self.notes.append(text)

    def summary(self) -> str:
        notes = " | ".join(self.notes)
        return f"{self.name}: {self.description} ({notes})"


__all__ = ["CharacterDossier"]
