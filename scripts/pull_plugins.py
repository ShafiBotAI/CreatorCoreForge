#!/usr/bin/env python3
"""Download a GitHub repository as a ZIP archive and extract it.

Adapted from the Requests library examples (Apache-2.0).
"""
import io
import sys
import zipfile
from pathlib import Path
import requests

def download_repo(repo: str, dest: Path) -> None:
    """Download repo in the form owner/repo to the destination directory."""
    url = f"https://codeload.github.com/{repo}/zip/refs/heads/master"
    resp = requests.get(url, timeout=30)
    resp.raise_for_status()
    with zipfile.ZipFile(io.BytesIO(resp.content)) as zf:
        zf.extractall(dest)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: pull_plugins.py owner/repo /path/to/dest")
        sys.exit(1)
    download_repo(sys.argv[1], Path(sys.argv[2]))
    print("Download complete")
