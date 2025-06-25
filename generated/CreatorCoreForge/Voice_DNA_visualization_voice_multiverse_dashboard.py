# Auto-generated for Voice DNA visualization, voice multiverse dashboard
from __future__ import annotations

from typing import Dict, Iterable


def voice_dna_visualization(dna_map: Dict[str, Iterable[str]]) -> str:
    """Return a simple HTML representation for ``dna_map``."""

    rows = []
    for parent, children in dna_map.items():
        items = "".join(f"<li>{c}</li>" for c in children)
        rows.append(f"<li>{parent}<ul>{items}</ul></li>")
    return f"<ul>{''.join(rows)}</ul>"


__all__ = ["voice_dna_visualization"]
