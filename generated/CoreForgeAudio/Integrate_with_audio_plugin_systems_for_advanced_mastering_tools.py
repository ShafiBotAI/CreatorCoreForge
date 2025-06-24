"""Lightweight plugin registry for mastering tools."""

from __future__ import annotations

from typing import Callable, Dict


PLUGIN_REGISTRY: Dict[str, Callable[[bytes], bytes]] = {}


def register_plugin(name: str, func: Callable[[bytes], bytes]) -> None:
    """Register a mastering plugin."""

    PLUGIN_REGISTRY[name] = func


def integrate_with_audio(name: str, data: bytes) -> bytes:
    """Apply plugin ``name`` to ``data`` if available."""

    plugin = PLUGIN_REGISTRY.get(name)
    return plugin(data) if plugin else data


__all__ = ["register_plugin", "integrate_with_audio"]
