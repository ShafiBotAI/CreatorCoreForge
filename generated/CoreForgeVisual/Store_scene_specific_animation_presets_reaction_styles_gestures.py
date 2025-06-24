# Auto-generated for Store scene-specific animation presets (reaction styles, gestures)

from dataclasses import dataclass, field
from typing import Dict

@dataclass
class AnimationPreset:
    name: str
    data: dict

class AnimationLibrary:
    def __init__(self):
        self.presets: Dict[str, AnimationPreset] = {}

    def add_preset(self, preset: AnimationPreset) -> None:
        self.presets[preset.name] = preset

    def get_preset(self, name: str) -> AnimationPreset | None:
        return self.presets.get(name)
