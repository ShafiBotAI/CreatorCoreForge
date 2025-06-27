# Auto-generated for Offline mode with cross-device sync
from __future__ import annotations


class OfflineSyncStore:
    """Simplistic key-value store that can sync with another store."""

    def __init__(self) -> None:
        self.data: dict[str, str] = {}
        self.version = 0

    def save(self, key: str, value: str) -> None:
        self.data[key] = value
        self.version += 1

    def fetch(self, key: str, default: str | None = None) -> str | None:
        return self.data.get(key, default)

    def sync(self, other: "OfflineSyncStore") -> None:
        """Synchronize data with ``other`` store."""
        if self.version >= other.version:
            other.data.update(self.data)
            other.version = self.version
        else:
            self.data.update(other.data)
            self.version = other.version


__all__ = ["OfflineSyncStore"]
