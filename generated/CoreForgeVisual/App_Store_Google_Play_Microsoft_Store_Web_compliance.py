# Auto-generated for App Store, Google Play, Microsoft Store, Web compliance
from __future__ import annotations

from typing import Dict


REQUIRED_FIELDS = {"name", "version", "icon"}


def app_store_google(metadata: Dict[str, str]) -> bool:
    """Return ``True`` if ``metadata`` satisfies basic store requirements."""

    return REQUIRED_FIELDS.issubset(metadata.keys())
