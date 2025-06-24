# Auto-generated for Maintain per-app AGENTS.md files
"""Utility to ensure each app directory contains a populated ``AGENTS.md`` file.

This script copies the task list from ``apps/AGENTS.md`` to each subfolder
within ``apps``.  If a subfolder lacks an ``AGENTS.md`` file one will be
created using a simple template.  Existing files are updated so that they at
least contain the master task list under a ``### Tasks`` section.

The goal is to keep per-app requirements in sync with the master roadmap.
"""

from __future__ import annotations

import re
from pathlib import Path


def _extract_master_tasks(master_text: str) -> str:
    """Return the ``### Tasks`` section from the master AGENTS file."""
    match = re.search(r"### Tasks\n(?P<tasks>(?:- .+\n)+)", master_text)
    return match.group("tasks") if match else ""


def maintain_per_app(base_dir: str = "apps") -> None:
    """Ensure all app folders contain up-to-date ``AGENTS.md`` files."""

    base = Path(base_dir)
    master_path = base / "AGENTS.md"
    if not master_path.exists():
        raise FileNotFoundError(f"Master file {master_path!s} not found")

    master_text = master_path.read_text(encoding="utf-8")
    master_tasks = _extract_master_tasks(master_text)

    for entry in base.iterdir():
        if not entry.is_dir() or entry.name.startswith("."):
            continue

        agent_file = entry / "AGENTS.md"

        if not agent_file.exists():
            header = f"# Agent: {entry.name}\n\nThis file tracks tasks for the {entry.name} application.\n\n"
            agent_file.write_text(header + "### Tasks\n" + master_tasks, encoding="utf-8")
            print(f"Created {agent_file}")
            continue

        content = agent_file.read_text(encoding="utf-8")
        if master_tasks and master_tasks not in content:
            if "### Tasks" in content:
                # replace existing tasks section
                updated = re.sub(r"### Tasks\n(?:- .+\n)+", f"### Tasks\n{master_tasks}", content)
            else:
                updated = content.strip() + "\n\n### Tasks\n" + master_tasks
            agent_file.write_text(updated, encoding="utf-8")
            print(f"Updated tasks in {agent_file}")

    print("Per-app AGENTS.md files are up to date.")


if __name__ == "__main__":
    maintain_per_app()

