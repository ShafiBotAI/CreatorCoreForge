"""Utilities for retrieving open Phase Nine tasks from the documentation."""
from pathlib import Path
import re

DOC_PATH = Path(__file__).resolve().parents[2] / "docs" / "PHASE_NINE.md"

def phase_nine_md_open() -> list[str]:
    """Return all unchecked Phase Nine tasks from the markdown file."""
    tasks: list[str] = []
    if DOC_PATH.exists():
        for line in DOC_PATH.read_text(encoding="utf-8").splitlines():
            m = re.match(r"- \[ \] (.+)", line.strip())
            if m:
                tasks.append(m.group(1))
    return tasks
