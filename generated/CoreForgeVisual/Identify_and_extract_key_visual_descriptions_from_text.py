"""Extract key visual description phrases from text."""
import re
from typing import List


def identify_and_extract(text: str) -> List[str]:
    """Return a list of adjective+noun phrases found in the text."""
    adjectives = (
        "dark|bright|red|blue|green|black|white|ancient|mystic|shadowy|sunny"
    )
    pattern = re.compile(rf"\b({adjectives})\s+(\w+)\b", re.IGNORECASE)
    seen = set()
    results: List[str] = []
    for match in pattern.finditer(text):
        phrase = f"{match.group(1).lower()} {match.group(2).lower()}"
        if phrase not in seen:
            seen.add(phrase)
            results.append(phrase)
    return results
