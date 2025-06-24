# Utility for extracting task lists from `docs/PRACTICAL_PLAN.md`.

from __future__ import annotations

import json
import re
from pathlib import Path


def parse_practical_plan(md_path: str | Path) -> dict[str, list[str]]:
    """Parse `PRACTICAL_PLAN.md` and return a mapping of sections to tasks."""

    sections: dict[str, list[str]] = {}
    current_section = None
    section_regex = re.compile(r"^##\s+(?:\d+\.\s+)?(.+)")
    task_regex = re.compile(r"^\d+\.\s+(.*)")

    with open(md_path, "r", encoding="utf-8") as handle:
        for line in handle:
            line = line.rstrip()

            match = section_regex.match(line)
            if match:
                current_section = match.group(1).strip()
                sections.setdefault(current_section, [])
                continue

            task_match = task_regex.match(line)
            if task_match and current_section:
                sections[current_section].append(task_match.group(1).strip())

    return sections


def practical_plan_md_initial(md_path: str | Path = "docs/PRACTICAL_PLAN.md") -> None:
    """Print tasks from the practical plan in a machine-readable format."""

    plan = parse_practical_plan(md_path)
    print(json.dumps(plan, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    practical_plan_md_initial()

