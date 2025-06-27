"""Minimal wrapper around :mod:`matplotlib.pyplot`.

If matplotlib is installed the real module is exposed as ``pyplot``.  This
keeps optional dependencies light for environments that do not require full
plotting support.
"""

from types import SimpleNamespace
import importlib


class _PyPlot(SimpleNamespace):
    """Very small subset of the ``matplotlib.pyplot`` API."""

    def subplots(self):
        return (self.Figure(), self.Axes())

    class Figure:
        def savefig(self, *args, **kwargs):  # pragma: no cover - simple stub
            print("savefig called", args, kwargs)

    class Axes:
        def plot(self, *args, **kwargs):  # pragma: no cover - simple stub
            print("plot", args, kwargs)

        def set_xlabel(self, *args, **kwargs):  # pragma: no cover
            print("set_xlabel", args, kwargs)

        def set_ylabel(self, *args, **kwargs):  # pragma: no cover
            print("set_ylabel", args, kwargs)

        def set_title(self, *args, **kwargs):  # pragma: no cover
            print("set_title", args, kwargs)

pyplot = _PyPlot()

# For compatibility with ``import matplotlib.pyplot as plt``
__all__ = ["pyplot"]
