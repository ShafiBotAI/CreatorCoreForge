# Auto-generated for Integrate memory graphs into multiverse and branch visualizers
from typing import Dict, List


def integrate_memory_graphs(graphs: List[Dict]) -> Dict[str, int]:
    """Merge multiple memory graphs and return simple statistics."""

    merged = {}
    for graph in graphs:
        for node in graph.get("nodes", []):
            merged[node] = merged.get(node, 0) + 1
    return merged
