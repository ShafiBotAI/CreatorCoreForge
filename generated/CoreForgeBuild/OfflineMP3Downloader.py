"""Simple offline MP3 downloader placeholder."""
from pathlib import Path


def download_mp3(url: str, dest: str) -> Path:
    """Write placeholder MP3 data to *dest* and return the path."""
    path = Path(dest)
    path.parent.mkdir(parents=True, exist_ok=True)
    # In offline mode we can't fetch real content, so write stub bytes
    path.write_bytes(b"MP3DATA" if url else b"")
    return path
