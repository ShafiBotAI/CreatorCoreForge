from typing import Iterable, Tuple

def support_drag_and(files: Iterable[str]) -> list[Tuple[str, str]]:
    """Return detected book formats for given file names."""
    results = []
    for name in files:
        lower = name.lower()
        if lower.endswith('.epub'):
            fmt = 'epub'
        elif lower.endswith('.pdf'):
            fmt = 'pdf'
        elif lower.endswith('.txt'):
            fmt = 'txt'
        else:
            fmt = 'unknown'
        results.append((name, fmt))
    return results
