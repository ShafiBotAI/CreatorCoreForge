"""Export finished audiobooks with metadata for store submission."""
from __future__ import annotations

import json
import os
import zipfile
from typing import Dict


def export_package(audio_path: str, metadata: Dict[str, str], out_dir: str) -> str:
    """Create a zipped package containing the audio file and metadata."""
    os.makedirs(out_dir, exist_ok=True)
    meta_path = os.path.join(out_dir, "metadata.json")
    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(metadata, f, ensure_ascii=False, indent=2)

    zip_path = os.path.join(out_dir, "audiobook_package.zip")
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        zf.write(audio_path, arcname=os.path.basename(audio_path))
        zf.write(meta_path, arcname="metadata.json")
    return zip_path


__all__ = ["export_package"]
