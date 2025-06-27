# Auto-generated for Cross-link translated memory arcs and character expressions over series
from __future__ import annotations

from typing import Dict, List


def cross_link_translated(arcs: Dict[str, List[str]], expressions: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Merge ``arcs`` and ``expressions`` keyed by character name."""

    result: Dict[str, List[str]] = {}
    for char, arc in arcs.items():
        result[char] = list(arc)
        if char in expressions:
            result[char].extend(expressions[char])
    for char, expr in expressions.items():
        result.setdefault(char, list(expr))
    return result
