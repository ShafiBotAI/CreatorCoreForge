# Auto-generated for Sync character visual memory with voice tone evolution
from typing import Dict


def sync_character_visual(memory: Dict[str, str], voice_tone: str) -> Dict[str, str]:
    """Update ``memory`` to reflect the current ``voice_tone``.

    The simple heuristic used here stores the latest voice tone as part of the
    character's visual style, giving downstream renderers a hint about how a
    character should appear based on how they sound.
    """

    memory = dict(memory)
    memory["voice_tone"] = voice_tone
    return memory
