# Auto-generated for Offer creator-branded export template themes (logos, font, outro)
from typing import Dict


def offer_creator_branded(theme: Dict[str, str]) -> str:
    """Return a simple descriptor string for the chosen theme."""

    return f"theme:{theme.get('logo','default')}|font:{theme.get('font','sans')}"
