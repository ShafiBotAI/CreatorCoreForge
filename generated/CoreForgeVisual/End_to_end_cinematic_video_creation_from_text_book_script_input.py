# Auto-generated for End-to-end cinematic video creation from text/book/script input
"""Simplified pipeline for turning text into a list of rendered scene files."""

from .AI_scene_dramatization_engine_for_turning_text_into_short_clips import (
    ai_scene_dramatization,
)
from .Scene_by_scene_video_dramatization_export_download import scene_by_scene


def end_to_end(text: str):
    """Convert ``text`` into basic scene clips and return exported file names."""

    clips = ai_scene_dramatization(text)
    scene_texts = [c.text for c in clips]
    return scene_by_scene(scene_texts)


__all__ = ["end_to_end"]
