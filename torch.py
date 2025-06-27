"""Minimal fallback implementation of a subset of the ``torch`` API.

This lightweight module provides just enough functionality for the
rest of the CreatorCoreForge codebase to run in environments where the
real ``torch`` package is unavailable. It intentionally implements only
the pieces that are actually used in tests and utility scripts.
"""

import os
from typing import Sequence

try:
    import numpy as _np  # type: ignore
except Exception:  # pragma: no cover - numpy may be missing
    _np = None


class cuda:
    """Minimal CUDA info stub."""

    @staticmethod
    def is_available() -> bool:
        # Allow overriding via environment for testing purposes.
        return os.environ.get("TORCH_FAKE_CUDA", "0") == "1"

    @staticmethod
    def device_count() -> int:
        return 1 if cuda.is_available() else 0

    @staticmethod
    def get_device_name(i: int) -> str:
        return f"FakeGPU-{i}"

def device(name: str) -> str:
    """Return the given device identifier."""
    return name

def rand(*shape: int, device: str | None = None):
    """Return an array of the given shape filled with random floats."""
    if _np is None:
        # Fall back to a very small Python-only implementation
        import random

        def _nested(current_shape: Sequence[int]):
            if len(current_shape) == 1:
                return [random.random() for _ in range(current_shape[0])]
            return [_nested(current_shape[1:]) for _ in range(current_shape[0])]

        return _nested(shape)
    return _np.random.rand(*shape)

def mm(a, b):
    """Matrix multiply ``a`` and ``b`` using ``numpy`` if available."""
    if _np is None:
        # Very naive pure-python multiplication for small lists
        result = [[0 for _ in range(len(b[0]))] for _ in range(len(a))]
        for i in range(len(a)):
            for j in range(len(b[0])):
                for k in range(len(b)):
                    result[i][j] += a[i][k] * b[k][j]
        return result
    return _np.matmul(a, b)
__version__ = "0.1"

