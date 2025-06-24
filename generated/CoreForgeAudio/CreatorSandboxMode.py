"""Simple sandbox context manager for creator experiments."""

from __future__ import annotations
from contextlib import contextmanager
from typing import Callable, List, Iterable


@contextmanager
def creatorsandboxmode(log: List[str] | None = None) -> Iterable[Callable[[str], None]]:
    """Yield a logger function that records actions into ``log``.

    Parameters
    ----------
    log:
        Optional list where actions will be appended. A new list is created if None.
    """
    actions: List[str] = log if log is not None else []

    def _record(action: str) -> None:
        actions.append(action)

    try:
        yield _record
    finally:
        pass


__all__ = ["creatorsandboxmode"]
