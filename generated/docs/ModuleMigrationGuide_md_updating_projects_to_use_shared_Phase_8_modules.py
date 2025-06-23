"""Extract migration steps from the ModuleMigrationGuide."""
from pathlib import Path

DOC_PATH = Path(__file__).resolve().parents[2] / "docs" / "ModuleMigrationGuide.md"

def modulemigrationguide_md_updating() -> list[str]:
    """Return bullet list items under the 'Migration Steps' section."""
    if not DOC_PATH.exists():
        return []
    in_section = False
    steps: list[str] = []
    for line in DOC_PATH.read_text(encoding="utf-8").splitlines():
        if line.strip().startswith("## Migration Steps"):
            in_section = True
            continue
        if in_section:
            if line.startswith("## ") and not line.startswith("## Migration Steps"):
                break
            if line.strip().startswith("-") or line.strip().startswith("1."):
                steps.append(line.strip("- ").strip())
    return steps
