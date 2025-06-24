# Auto-generated for **AI scene dramatization engine** for turning text into short clips
from dataclasses import dataclass
from typing import List


@dataclass
class Clip:
    text: str
    index: int


def ai_scene_dramatization(text: str) -> List[Clip]:
    """Very basic dramatization splitting paragraphs into clips."""
    clips = []
    for i, block in enumerate(filter(None, (p.strip() for p in text.split("\n\n")))):
        clips.append(Clip(text=block, index=i))
    return clips
