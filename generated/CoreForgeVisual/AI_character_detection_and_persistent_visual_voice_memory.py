# Auto-generated for AI character detection and persistent visual/voice memory
import re

_character_memory = {}

def ai_character_detection(text: str):
    """Return a set of character names detected in the given text."""
    potential_names = re.findall(r"[A-Z][a-zA-Z]+", text)
    characters = set(potential_names)
    for name in characters:
        _character_memory.setdefault(name, {"voice": None, "visual": None})
    return characters

def update_character_voice(name: str, voice: str):
    """Persist voice tone for a character."""
    if name in _character_memory:
        _character_memory[name]["voice"] = voice

def update_character_visual(name: str, description: str):
    """Persist visual description for a character."""
    if name in _character_memory:
        _character_memory[name]["visual"] = description

def character_memory():
    """Expose stored character memory for testing."""
    return dict(_character_memory)
