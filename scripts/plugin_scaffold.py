#!/usr/bin/env python3
"""Simple CLI to scaffold a plugin directory with manifest."""
import argparse
import json
from pathlib import Path


def scaffold(name: str, dest: Path) -> None:
    dest.mkdir(parents=True, exist_ok=True)
    manifest = {
        "name": name,
        "version": "0.1.0",
        "inputs": [],
        "outputs": [],
        "permissions": [],
        "premium": False,
        "price": None,
    }
    with open(dest / "manifest.json", "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2)
    code_path = dest / f"{name}.py"
    with open(code_path, "w", encoding="utf-8") as f:
        f.write(f"# {name} plugin\n\n")
        f.write("def run(data):\n    return data\n")
    print(f"Created plugin scaffold at {dest}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Create plugin scaffold")
    parser.add_argument("name")
    parser.add_argument("dest", nargs="?", default=".")
    args = parser.parse_args()
    scaffold(args.name, Path(args.dest))


if __name__ == "__main__":
    main()
