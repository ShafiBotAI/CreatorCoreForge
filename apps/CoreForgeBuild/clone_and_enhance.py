#!/usr/bin/env python3
"""Clone a GitHub repository and suggest next-gen features to integrate."""
import json
import subprocess
import sys
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[2]
FEATURE_FILE = ROOT_DIR / "features-phase8.json"


def clone_repo(repo_url: str, dest: Path) -> None:
    """Clone repo_url into dest."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    subprocess.check_call(["git", "clone", repo_url, str(dest)])


def load_features(n: int = 25):
    """Load the first ``n`` next-gen features for CoreForge Build."""
    with FEATURE_FILE.open("r", encoding="utf-8") as f:
        data = json.load(f)
    features = data.get("phase8Features", {}).get("CoreForgeBuild", [])
    return features[:n]


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print("Usage: clone_and_enhance.py <github_repo_url> <destination>")
        return 1
    repo_url = argv[1]
    dest = Path(argv[2])
    clone_repo(repo_url, dest)
    print("\nRepository cloned to", dest)
    print("\nRecommended next-gen features to integrate:")
    for feature in load_features():
        print(f"- {feature}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
