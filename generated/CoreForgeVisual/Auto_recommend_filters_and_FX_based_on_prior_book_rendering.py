# Auto-generated for Auto-recommend filters and FX based on prior book rendering
from typing import List, Dict


def auto_recommend_filters(history: List[Dict]) -> List[str]:
    """Return a list of recommended filter names based on ``history`` records."""

    counts: Dict[str, int] = {}
    for record in history:
        name = record.get("filter")
        if not name:
            continue
        counts[name] = counts.get(name, 0) + 1

    # Recommend the most frequently used filters
    return sorted(counts, key=counts.get, reverse=True)
