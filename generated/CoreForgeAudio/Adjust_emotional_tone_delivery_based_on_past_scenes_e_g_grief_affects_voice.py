# Auto-generated for Adjust emotional tone delivery based on past scenes (e.g., grief affects voice)
from typing import List


def adjust_emotional_tone(history: List[str], line: str) -> str:
    """Return adjusted tone label based on past emotional history.

    Args:
        history: List of emotion labels from previous scenes.
        line: Current line of dialogue or narration.

    Returns:
        Suggested emotion label for the line.
    """

    if not history:
        return "neutral"

    last_emotion = history[-1]

    if "grief" in last_emotion.lower():
        return "somber"
    if "joy" in last_emotion.lower():
        return "upbeat"

    return last_emotion
