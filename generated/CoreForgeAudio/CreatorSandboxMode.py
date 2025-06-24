
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
=======
# Auto-generated for CreatorSandboxMode
"""Context manager for temporary sandbox workspaces."""

from __future__ import annotations

import shutil
import tempfile
from contextlib import contextmanager
from pathlib import Path


@contextmanager
def creatorsandboxmode(base_dir: str | None = None) -> Path:
    """Yield a temporary directory for experimentation.

    The directory is removed on exit.
    """

    path = Path(tempfile.mkdtemp(dir=base_dir))
    try:
        yield path
    finally:
        shutil.rmtree(path, ignore_errors=True)



__all__ = ["creatorsandboxmode"]
