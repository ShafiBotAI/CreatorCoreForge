"""Context manager for temporary sandbox workspaces."""

from __future__ import annotations

import shutil
import tempfile
from contextlib import contextmanager
from pathlib import Path

__all__ = ["creatorsandboxmode"]

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
