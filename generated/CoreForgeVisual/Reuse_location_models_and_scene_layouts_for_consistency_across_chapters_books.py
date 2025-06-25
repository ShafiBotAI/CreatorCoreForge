# Auto-generated for Reuse location models and scene layouts for consistency across chapters/books
from typing import Dict


def reuse_location_models(cache: Dict[str, Dict], location_id: str, layout: Dict) -> Dict[str, Dict]:
    """Store ``layout`` in ``cache`` keyed by ``location_id`` and return the cache."""

    cache = dict(cache)
    cache[location_id] = layout
    return cache
