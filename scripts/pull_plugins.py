#!/usr/bin/env python3
"""Download plugins or code snippets from public GitHub repositories.

This utility fetches a repository archive from GitHub and extracts it under
`apps/CoreForgeBuild/plugins`. Use it to pull open-source plugins referenced by
CoreForge Build.
"""
import argparse
import io
import os
import zipfile
import requests

PLUGIN_DIR = os.path.join(os.path.dirname(__file__), '..', 'apps', 'CoreForgeBuild', 'plugins')


def fetch_repo_archive(repo: str, ref: str) -> bytes:
    url = f"https://codeload.github.com/{repo}/zip/{ref}"
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.content


def extract_archive(data: bytes, dest: str):
    with zipfile.ZipFile(io.BytesIO(data)) as zf:
        zf.extractall(dest)


def main():
    parser = argparse.ArgumentParser(description="Fetch a GitHub repo into plugins directory")
    parser.add_argument("repo", help="GitHub repo in owner/repo format")
    parser.add_argument("--ref", default="main", help="Branch or tag (default: main)")
    args = parser.parse_args()

    os.makedirs(PLUGIN_DIR, exist_ok=True)
    archive = fetch_repo_archive(args.repo, args.ref)
    extract_archive(archive, PLUGIN_DIR)
    print(f"Fetched {args.repo}@{args.ref} to {PLUGIN_DIR}")


if __name__ == "__main__":
    main()
