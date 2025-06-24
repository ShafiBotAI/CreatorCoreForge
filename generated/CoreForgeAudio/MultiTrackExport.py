"""Utility to export multiple audio tracks into a single archive."""
from __future__ import annotations
import os
import zipfile
from typing import Dict, Iterable

from pydub import AudioSegment


def multitrack_export(tracks: Dict[str, AudioSegment], out_dir: str, archive: bool = True) -> str:
    """Save audio tracks to ``out_dir`` and optionally create a ``.zip`` archive.

    Parameters
    ----------
    tracks: mapping of track name to ``AudioSegment`` data
    out_dir: directory where files will be written
    archive: whether to zip the resulting files

    Returns
    -------
    str
        Path to the archive or directory containing the exported tracks.
    """
    os.makedirs(out_dir, exist_ok=True)
    for name, segment in tracks.items():
        file_path = os.path.join(out_dir, f"{name}.wav")
        segment.export(file_path, format="wav")

    if archive:
        zip_path = os.path.join(out_dir, "tracks.zip")
        with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:
            for name in tracks.keys():
                zipf.write(os.path.join(out_dir, f"{name}.wav"), arcname=f"{name}.wav")
        return zip_path
    else:
        return out_dir

__all__ = ["multitrack_export"]
