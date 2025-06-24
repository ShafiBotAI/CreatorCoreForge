# Auto-generated for Track export history by book, scene, and version
from typing import Dict, List, Tuple

_history: Dict[str, List[Tuple[str, str]]] = {}


def track_export_history(book: str, scene: str, version: str) -> None:
    """Record an export entry for a given book and scene."""
    key = f"{book}:{scene}"
    _history.setdefault(key, []).append((version, book))


def get_export_history(book: str, scene: str) -> List[Tuple[str, str]]:
    """Retrieve export history for a specific book and scene."""
    return _history.get(f"{book}:{scene}", [])
