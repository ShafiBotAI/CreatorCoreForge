# Auto-generated for Flag high-action and dialogue-heavy scenes for rendering priority
from typing import List
import re


def flag_high_action(scenes: List[str]) -> List[int]:
    """Return indexes of scenes that appear high-action or dialogue heavy."""

    flagged: List[int] = []
    dialogue_re = re.compile(r'"[^"]+"')

    for idx, scene in enumerate(scenes):
        exclaim_count = scene.count('!')
        dialogue_count = len(dialogue_re.findall(scene))
        words = scene.split()

        if exclaim_count > 2 or (dialogue_count > 5 or dialogue_count > len(words) * 0.1):
            flagged.append(idx)

    return flagged
