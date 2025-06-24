# Auto-generated for Track costume and hairstyle changes throughout story for visual consistency
from collections import defaultdict
from dataclasses import dataclass

@dataclass
class Appearance:
    costume: str
    hairstyle: str

class CostumeTracker:
    def __init__(self):
        self._history = defaultdict(dict)

    def record(self, character: str, scene: str, appearance: Appearance):
        """Store the costume and hairstyle for ``character`` in ``scene``."""
        self._history[character][scene] = appearance

    def last_known(self, character: str) -> Appearance | None:
        scenes = self._history.get(character)
        if not scenes:
            return None
        last_scene = sorted(scenes.keys())[-1]
        return scenes[last_scene]
