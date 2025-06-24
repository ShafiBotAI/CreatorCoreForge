# Auto-generated for Model relationships: voice modulation changes depending on who is speaking to whom
from typing import Dict


def model_relationships_voice(speaker: str, listener: str, relationships: Dict[str, str]) -> str:
    """Return voice modulation tag based on relationship."""

    key = f"{speaker}:{listener}"
    if key in relationships:
        return relationships[key]

    if speaker == listener:
        return "introspective"

    return relationships.get("default", "neutral")
