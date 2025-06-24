# Auto-generated for CrossoverEngine
from typing import Dict, List


def crossoverengine(series_a: List[Dict], series_b: List[Dict]) -> Dict[str, List[str]]:
    """Create simple crossover mapping between two series.

    Args:
        series_a: List of character dictionaries from series A.
        series_b: List of character dictionaries from series B.

    Returns:
        Dictionary mapping character names to a list of crossover appearances.
    """

    crossover_map: Dict[str, List[str]] = {}
    names_b = {c["name"] for c in series_b}

    for char in series_a:
        name = char["name"]
        if name in names_b:
            crossover_map.setdefault(name, []).append("both")
        else:
            crossover_map.setdefault(name, []).append("A")

    for char in series_b:
        name = char["name"]
        if name not in crossover_map:
            crossover_map[name] = ["B"]

    return crossover_map
