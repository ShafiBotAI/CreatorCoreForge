# Auto-generated for Flag content sensitive to region/culture for modification options
from __future__ import annotations

from typing import Dict, List


SENSITIVE_TERMS: Dict[str, List[str]] = {
    "JP": ["imperial"],
    "US": ["gun violence"],
}


def flag_content_sensitive(text: str, region: str) -> List[str]:
    """Return a list of sensitive terms found in ``text`` for ``region``."""

    terms = SENSITIVE_TERMS.get(region.upper(), [])
    return [t for t in terms if t.lower() in text.lower()]

