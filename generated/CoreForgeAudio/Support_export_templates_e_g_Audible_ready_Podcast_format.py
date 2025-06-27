# Auto-generated for Support export templates (e.g., Audible-ready, Podcast format)
"""Manage export templates for various audio platforms."""

from __future__ import annotations


class ExportTemplateRegistry:
    """Registry of export templates and their options."""

    _templates = {
        "audible": {"bitrate": 128, "format": "mp3"},
        "podcast": {"bitrate": 96, "format": "mp3"},
    }

    @classmethod
    def get(cls, name: str) -> dict | None:
        return cls._templates.get(name)

    @classmethod
    def add(cls, name: str, options: dict) -> None:
        cls._templates[name] = options


__all__ = ["ExportTemplateRegistry"]
