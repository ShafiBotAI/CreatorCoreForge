# Auto-generated for Save cultural localization settings for franchise or series consistency
from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict


def save_cultural_localization(franchise: str, settings: Dict[str, Any], directory: str) -> Path:
    """Persist localization settings for the given franchise in a JSON file.

    Parameters
    ----------
    franchise:
        Name of the franchise or series.
    settings:
        Dictionary of localization options (e.g. language, region, censorship).
    directory:
        Folder in which to store the settings file.

    Returns
    -------
    Path
        The path to the saved file.
    """

    Path(directory).mkdir(parents=True, exist_ok=True)
    file_path = Path(directory) / f"{franchise}_localization.json"
    with file_path.open("w", encoding="utf-8") as fp:
        json.dump(settings, fp, ensure_ascii=False, indent=2)
    return file_path

