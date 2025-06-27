# Auto-generated for Allow creator review of language-adapted visuals before rendering
from __future__ import annotations

from typing import Callable, Iterable, List


def allow_creator_review(visuals: Iterable[str], approve: Callable[[str], bool]) -> List[str]:
    """Filter adapted visuals based on a creator approval callback.

    Parameters
    ----------
    visuals:
        Iterable of visual identifiers or paths awaiting review.
    approve:
        Function that returns ``True`` if the creator approves the visual.

    Returns
    -------
    List[str]
        List of approved visuals.
    """

    return [v for v in visuals if approve(v)]

