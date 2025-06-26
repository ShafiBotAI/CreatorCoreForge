# Auto-generated for Auto bundler for all platforms
"""Create simple bundle files for each target platform."""

from pathlib import Path
from typing import Iterable, List


def auto_bundler_for(platforms: Iterable[str], output_dir: str = "dist") -> List[str]:
    """Write placeholder bundle files and return their paths."""
    out = Path(output_dir)
    out.mkdir(exist_ok=True)
    results = []
    for platform in platforms:
        bundle = out / f"{platform}.bundle"
        bundle.write_text(f"bundle for {platform}")
        results.append(str(bundle))
    return results


__all__ = ["auto_bundler_for"]
