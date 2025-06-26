# Auto-generated for Figma-driven UI builder
"""Parse simplified Figma JSON and return node names."""

import json
from typing import List


def figma_driven_ui(json_str: str) -> List[str]:
    """Return a list of node names from a Figma export snippet."""
    try:
        data = json.loads(json_str)
        nodes = data.get("nodes", [])
        return [n.get("name", "") for n in nodes if isinstance(n, dict)]
    except Exception:
        return []


__all__ = ["figma_driven_ui"]
