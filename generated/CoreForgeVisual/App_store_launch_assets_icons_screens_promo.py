# Auto-generated for App store/launch assets (icons, screens, promo)
from __future__ import annotations

from pathlib import Path
from typing import Iterable


def app_store_launch(assets: Iterable[Path], dest: Path) -> Path:
    """Copy ``assets`` into ``dest`` directory."""

    dest.mkdir(parents=True, exist_ok=True)
    for asset in assets:
        target = dest / asset.name
        target.write_bytes(asset.read_bytes())
    return dest
