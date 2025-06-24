"""Summaries for the production roadmap documentation."""
from pathlib import Path
import re

DOC_PATH = Path(__file__).resolve().parents[2] / "docs" / "PRODUCTION_ROADMAP.md"

def production_roadmap_md_high() -> list[str]:
    """Return top-level sections from the production roadmap."""
    if not DOC_PATH.exists():
        return []
    sections: list[str] = []
    for line in DOC_PATH.read_text(encoding="utf-8").splitlines():
        if line.startswith("## "):
            sections.append(line[3:])
    return sections
