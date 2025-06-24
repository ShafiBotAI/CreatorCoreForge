# Auto-generated for Cross-reference visual scene files with narration or audio timeline
from typing import List, Tuple


def cross_reference_visual(visual_scenes: List[str], audio_scenes: List[str]) -> List[Tuple[str, str]]:
    """Pair visual scenes with audio scenes by index."""

    pairs = []
    for i, v in enumerate(visual_scenes):
        a = audio_scenes[i] if i < len(audio_scenes) else ""
        pairs.append((v, a))
    return pairs
