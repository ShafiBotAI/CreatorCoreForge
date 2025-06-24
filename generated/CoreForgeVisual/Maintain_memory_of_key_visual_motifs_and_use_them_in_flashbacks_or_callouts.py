# Auto-generated for Maintain memory of key visual motifs and use them in flashbacks or callouts
from typing import Dict, List

_motif_db: Dict[str, List[str]] = {}


def maintain_memory_of(book: str, motifs: List[str]) -> None:
    """Add motifs to a book's motif memory."""

    store = _motif_db.setdefault(book, [])
    for motif in motifs:
        if motif not in store:
            store.append(motif)


def recall_motifs(book: str) -> List[str]:
    """Return stored motifs for a book."""

    return _motif_db.get(book, [])
