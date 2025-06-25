"""Offer creator-branded export template themes with logo and font options."""
from typing import Dict

__all__ = ["offer_creator_branded"]

def offer_creator_branded(theme: Dict[str, str]) -> str:
    """Return a simple descriptor string for the chosen theme."""
    logo = theme.get("logo", "default")
    font = theme.get("font", "sans")
    return f"logo:{logo}|font:{font}"
