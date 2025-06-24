"""Simple in-memory cross-platform progress synchronization."""
from collections import defaultdict
from dataclasses import dataclass
from typing import Dict

@dataclass
class Progress:
    level: int
    points: int

class ProgressSync:
    """Track progress for players across multiple devices."""
    def __init__(self) -> None:
        self._data: Dict[str, Progress] = {}

    def update(self, player_id: str, level: int, points: int) -> None:
        self._data[player_id] = Progress(level, points)

    def retrieve(self, player_id: str) -> Progress | None:
        return self._data.get(player_id)

progress_sync = ProgressSync()
