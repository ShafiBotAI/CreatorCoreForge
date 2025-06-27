# Auto-generated for Scene and voice tagging UI, live emotion indicators
"""Tools for tagging scenes with voice assignments and emotions."""

from __future__ import annotations


class SceneVoiceTagger:
    """In-memory store for scene and voice emotion tags."""

    def __init__(self) -> None:
        self._records: list[dict] = []

    def tag_scene(self, scene_id: str, character: str, emotion: str) -> None:
        self._records.append({
            "scene": scene_id,
            "character": character,
            "emotion": emotion,
        })

    def tags_for_scene(self, scene_id: str) -> list[dict]:
        return [r for r in self._records if r["scene"] == scene_id]


__all__ = ["SceneVoiceTagger"]
