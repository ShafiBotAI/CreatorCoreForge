# Auto-generated for Keep each subfolder in sync with master roadmap
"""Synchronize app subfolders with the master roadmap.

This helper relies on ``maintain_per_app_AGENTS_md_files`` to ensure each
application directory contains an ``AGENTS.md`` file mirroring the master tasks.
Additional synchronization hooks can be added as the project evolves.
"""

from __future__ import annotations

from pathlib import Path

from .Maintain_per_app_AGENTS_md_files import maintain_per_app


def keep_each_subfolder(base_dir: str = "apps") -> None:
    """Keep each subfolder in sync with the master roadmap."""

    if not Path(base_dir).is_dir():
        raise FileNotFoundError(f"Base directory {base_dir!s} not found")

    maintain_per_app(base_dir)


if __name__ == "__main__":
    keep_each_subfolder()

