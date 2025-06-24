import json
import re
from pathlib import Path


def parse_markdown_features(md_lines):
    """Parse features from PHASE_EIGHT.md, returning a mapping of app -> features."""
    features = {}
    current_app = None
    header_re = re.compile(r"^###\s+(.*)")
    feature_re = re.compile(r"^-\s*\[[x ]\]\s*(.+)")
    for line in md_lines:
        header_match = header_re.match(line)
        if header_match:
            current_app = header_match.group(1).strip()
            features[current_app] = []
            continue
        if current_app:
            m = feature_re.match(line)
            if m:
                features[current_app].append(m.group(1).strip())
    return features


def keep_phase_eight_md(md_path: Path = Path("docs/PHASE_EIGHT.md"),
                        json_path: Path = Path("features-phase8.json")) -> bool:
    """Ensure PHASE_EIGHT.md lists all features from features-phase8.json.

    Returns True if the file was updated.
    """
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    desired = data.get("phase8Features", {})

    with open(md_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    md_features = parse_markdown_features(lines)
    updated = False

    for app, feats in desired.items():
        doc_feats = md_features.get(app, [])
        missing = [f for f in feats if f not in doc_feats]
        if not missing:
            continue
        updated = True
        try:
            idx = next(i for i, l in enumerate(lines) if l.strip() == f"### {app}") + 1
        except StopIteration:
            # append new heading if not found
            lines.append(f"\n### {app}\n")
            idx = len(lines)
        for feat in missing:
            lines.insert(idx, f"- [ ] {feat}\n")
            idx += 1

    if updated:
        with open(md_path, "w", encoding="utf-8") as f:
            f.writelines(lines)
    return updated


if __name__ == "__main__":
    changed = keep_phase_eight_md()
    if changed:
        print("PHASE_EIGHT.md updated with new features.")
    else:
        print("PHASE_EIGHT.md already up to date.")
