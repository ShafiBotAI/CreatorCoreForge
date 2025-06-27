# Auto-generated for **AI scene dramatization engine** for turning text into short clips
from dataclasses import dataclass
from typing import List
import re


@dataclass
class Clip:
    text: str
    index: int


def ai_scene_dramatization(text: str, max_sentences: int = 3) -> List[Clip]:
    """Convert raw text into a list of scene clips."""
    paragraphs = [p.strip() for p in text.splitlines() if p.strip()]
    clips: List[Clip] = []
    index = 0
    for para in paragraphs:
        sentences = re.split(r"(?<=[.!?])\s+", para)
        for i in range(0, len(sentences), max_sentences):
            part = " ".join(sentences[i : i + max_sentences]).strip()
            if part:
                clips.append(Clip(text=part, index=index))
                index += 1
    return clips
