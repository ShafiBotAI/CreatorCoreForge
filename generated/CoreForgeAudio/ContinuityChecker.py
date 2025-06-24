# Auto-generated for ContinuityChecker
from typing import List, Dict


def continuitychecker(scenes: List[Dict]) -> List[str]:
    """Simple continuity checker.

    Args:
        scenes: List of scene dictionaries with `location` and `characters` keys.

    Returns:
        List of notes describing potential continuity issues.
    """

    notes = []
    last_location = None
    last_characters = set()

    for idx, scene in enumerate(scenes):
        location = scene.get("location")
        characters = set(scene.get("characters", []))

        if last_location and location != last_location:
            notes.append(f"Scene {idx}: location changed from {last_location} to {location}")

        missing_chars = last_characters - characters
        if missing_chars:
            notes.append(f"Scene {idx}: characters missing from previous scene: {', '.join(missing_chars)}")

        last_location = location
        last_characters = characters

    return notes
