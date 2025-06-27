# Auto-generated for 1-year+ persistent memory pinning for series and sequels
"""Simple file-based memory store with a one year expiry."""

from __future__ import annotations

import json
from datetime import datetime, timedelta
from pathlib import Path

MEMORY_FILE = Path(__file__).resolve().parents[2] / "memory_store.json"


def load_memory(series_id: str) -> dict:
    """Return memory for ``series_id`` if not expired."""

    if not MEMORY_FILE.exists():
        return {}
    data = json.loads(MEMORY_FILE.read_text())
    entry = data.get(series_id)
    if not entry:
        return {}
    ts = datetime.fromisoformat(entry["timestamp"])
    if datetime.now() - ts > timedelta(days=365):
        return {}
    return entry.get("memory", {})


def save_memory(series_id: str, memory: dict) -> None:
    """Persist ``memory`` for ``series_id`` with a timestamp."""

    if MEMORY_FILE.exists():
        data = json.loads(MEMORY_FILE.read_text())
    else:
        data = {}
    data[series_id] = {"timestamp": datetime.now().isoformat(), "memory": memory}
    MEMORY_FILE.write_text(json.dumps(data, indent=2))


__all__ = ["load_memory", "save_memory"]
