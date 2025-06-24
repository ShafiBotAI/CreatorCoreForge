"""Utilities for basic multiplayer events and leaderboards."""
from dataclasses import dataclass, field
from typing import Dict, List

@dataclass(order=True)
class LeaderboardEntry:
    score: int
    player_id: str = field(compare=False)

class Leaderboard:
    def __init__(self) -> None:
        self._entries: Dict[str, int] = {}

    def record_score(self, player_id: str, score: int) -> None:
        if score > self._entries.get(player_id, 0):
            self._entries[player_id] = score

    def top(self, n: int = 10) -> List[LeaderboardEntry]:
        return sorted(
            [LeaderboardEntry(score, pid) for pid, score in self._entries.items()],
            reverse=True
        )[:n]

leaderboard = Leaderboard()
