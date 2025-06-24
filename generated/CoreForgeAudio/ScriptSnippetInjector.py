"""Utilities to insert text snippets into a script."""

from __future__ import annotations


def scriptsnippetinjector(
    script: str, snippet: str, position: int | None = None
) -> str:
    """Return ``script`` with ``snippet`` inserted at ``position``.

    Parameters
    ----------
    script:
        Original multi-line script content.
    snippet:
        Text snippet to insert.
    position:
        Zero-based line index to insert at. Defaults to appending.
    """
    lines = script.splitlines()
    if position is None or position >= len(lines):
        lines.append(snippet)
    else:
        lines.insert(max(position, 0), snippet)
    return "\n".join(lines)


__all__ = ["scriptsnippetinjector"]
