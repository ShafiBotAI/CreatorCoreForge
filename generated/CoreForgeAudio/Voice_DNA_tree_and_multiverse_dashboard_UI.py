# Auto-generated for Voice DNA tree and multiverse dashboard UI
from __future__ import annotations

from typing import Dict, Iterable


def voice_dna_tree(dna_map: Dict[str, Iterable[str]]) -> str:
    """Return a simple HTML list visualizing ``dna_map``."""

    rows = []
    for parent, children in dna_map.items():
        children_li = "".join(f"<li>{c}</li>" for c in children)
        rows.append(f"<li>{parent}<ul>{children_li}</ul></li>")
    return f"<ul>{''.join(rows)}</ul>"


__all__ = ["voice_dna_tree"]
