# Auto-generated for Offer export options for localized versions per country
from __future__ import annotations

from pathlib import Path
from typing import Dict, Iterable


def offer_export_options(countries: Iterable[str], base_file: str) -> Dict[str, Path]:
    """Create per-country export file names based on ``base_file``.

    Parameters
    ----------
    countries:
        Iterable of country codes, e.g. ["US", "JP"].
    base_file:
        The base path of the file to export (without extension).

    Returns
    -------
    Dict[str, Path]
        Mapping of country code to localized file path.
    """

    result: Dict[str, Path] = {}
    base = Path(base_file)
    for code in countries:
        localized = base.with_name(f"{base.stem}_{code}{base.suffix}")
        result[code] = localized
    return result

