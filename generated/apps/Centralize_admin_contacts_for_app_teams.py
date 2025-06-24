# Auto-generated for Centralize admin contacts for app teams
"""Aggregate admin contact details from each app folder."""

from __future__ import annotations

import csv
import os
import re
from pathlib import Path


def centralize_admin_contacts(base_dir: str = "apps", output_file: str = "docs/admin_contacts.csv") -> list[tuple[str, str]]:
    """Scan ``AGENTS.md`` and ``README.md`` files for admin contact lines."""

    contacts: list[tuple[str, str]] = []
    pattern = re.compile(r"Admin(?: Contact)?:\s*(.+)", re.IGNORECASE)

    for root, _dirs, files in os.walk(base_dir):
        for name in files:
            if name.lower() in {"agents.md", "readme.md"}:
                path = Path(root) / name
                with open(path, "r", errors="ignore") as f:
                    for line in f:
                        m = pattern.search(line)
                        if m:
                            app = Path(root).name
                            contacts.append((app, m.group(1).strip()))

    if contacts:
        Path(output_file).parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, "w", newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(["app", "contact"])
            writer.writerows(contacts)
    return contacts


if __name__ == "__main__":
    centralize_admin_contacts()

