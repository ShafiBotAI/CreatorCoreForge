# Auto-generated for App store policy compliance (export, NSFW, region lock)
from __future__ import annotations

from typing import Dict


def app_store_policy(settings: Dict[str, bool]) -> bool:
    """Validate that required policy flags are set."""

    return settings.get("allow_export", False) and not settings.get("nsfw_locked", False)
