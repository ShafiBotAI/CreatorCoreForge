# Auto-generated for Support tone comparison mode between books for authorial analysis
from typing import Dict, List


def support_tone_comparison(book_a: Dict[str, float], book_b: Dict[str, float]) -> Dict[str, float]:
    """Compare tone metrics between two books and return the delta per tone."""
    delta: Dict[str, float] = {}
    keys: List[str] = list(set(book_a) | set(book_b))
    for key in keys:
        delta[key] = book_b.get(key, 0.0) - book_a.get(key, 0.0)
    return delta
