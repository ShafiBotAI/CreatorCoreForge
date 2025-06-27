# Auto-generated for APISetup.md (integration steps for all APIs, LocalVoiceAI, Firebase)
from pathlib import Path
from typing import Dict, List


def apisetup_md_integration(path: str | Path = Path("apps/CoreForgeAudio/APISetup.md")) -> Dict[str, List[str]]:
    """Parse ``APISetup.md`` and return a mapping of section titles to steps.

    The parser looks for level-2 headings (``##``) and collects bullet points
    beneath each heading. This lightweight helper allows other modules to access
    integration instructions programmatically.
    """

    path = Path(path)
    sections: Dict[str, List[str]] = {}
    current: str | None = None

    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except FileNotFoundError:
        return sections

    for line in lines:
        if line.startswith("## "):
            current = line[3:].strip()
            sections[current] = []
        elif line.lstrip().startswith("- ") and current:
            sections[current].append(line.lstrip("- ").strip())

    return sections


__all__ = ["apisetup_md_integration"]
