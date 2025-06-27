"""Toggle a simple creator sandbox mode using an environment variable."""
from __future__ import annotations
import os

_SANDBOX_VAR = "COREFORGE_SANDBOX"


def enable_creator_sandbox(enabled: bool = True) -> None:
    """Enable or disable sandbox mode."""
    os.environ[_SANDBOX_VAR] = "1" if enabled else "0"


def is_creator_sandbox_enabled() -> bool:
    """Return ``True`` if sandbox mode is active."""
    return os.getenv(_SANDBOX_VAR) == "1"

__all__ = ["enable_creator_sandbox", "is_creator_sandbox_enabled"]
