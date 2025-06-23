#!/usr/bin/env python3
"""Download a GitHub repository as a ZIP archive and extract it.

Adapted from the Requests library examples (Apache-2.0).
"""
import io
import sys
import zipfile
from pathlib import Path
import requests

def download_repo(repo: str, dest: Path, branch: str = "master") -> None:
    """Download repo in the form owner/repo to the destination directory."""
    dest.mkdir(parents=True, exist_ok=True)
    url = f"https://codeload.github.com/{repo}/zip/refs/heads/{branch}"
    resp = requests.get(url, timeout=30)
    resp.raise_for_status()
    with zipfile.ZipFile(io.BytesIO(resp.content)) as zf:
        zf.extractall(dest)

if __name__ == "__main__":
    if not 3 <= len(sys.argv) <= 4:
        print("Usage: pull_plugins.py owner/repo /path/to/dest [branch]")
        sys.exit(1)

    repo = sys.argv[1]
    dest = Path(sys.argv[2])
    branch = sys.argv[3] if len(sys.argv) == 4 else "master"

    download_repo(repo, dest, branch)
    print("Download complete")
