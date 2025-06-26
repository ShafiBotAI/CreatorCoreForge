# Auto-generated for Detect and flag conflicts when characters appear in multiple branches simultaneously
from typing import Dict, List, Set


def detect_and_flag(branches: Dict[str, List[Set[str]]]) -> Dict[int, Set[str]]:
    """Return characters appearing in multiple branches at the same index."""

    conflicts: Dict[int, Set[str]] = {}
    if not branches:
        return conflicts

    max_len = max(len(s) for s in branches.values())
    for i in range(max_len):
        seen: Dict[str, int] = {}
        for tag, seq in branches.items():
            if i < len(seq):
                for char in seq[i]:
                    if char in seen:
                        conflicts.setdefault(i, set()).add(char)
                    else:
                        seen[char] = i
    return conflicts
