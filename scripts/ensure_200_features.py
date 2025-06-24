import json
import re
import sys
from pathlib import Path

ACTIONS = [
    "Adaptive",
    "Advanced",
    "Quantum",
    "Smart",
    "Dynamic",
    "Automated",
    "Enhanced",
    "Virtual",
    "Integrated",
    "Pro"
]

COMPONENTS = [
    "Engine",
    "Module",
    "Manager",
    "Service",
    "Toolkit",
    "System",
    "Interface",
    "Analyzer",
    "Workflow",
    "Pipeline"
]


def generate_feature(prefix: str, idx: int) -> str:
    action = ACTIONS[idx % len(ACTIONS)]
    component = COMPONENTS[idx % len(COMPONENTS)]
    return f"{action}{prefix}{component}{idx:03d}"


def ensure_200_features(json_path: Path):
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    updated = False
    for app, features in data.get("phase8Features", {}).items():
        prefix = re.sub(r"^CoreForge", "", app)
        count = len(features)
        while count < 200:
            idx = count + 1
            feature = generate_feature(prefix, idx)
            if feature in features:
                idx += 1
                continue
            features.append(feature)
            count += 1
            updated = True
    if updated:
        with open(json_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2)
    return updated


if __name__ == "__main__":
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("features-phase8.json")
    changed = ensure_200_features(path)
    if changed:
        print(f"Updated {path} with placeholder features to reach 200 per app.")
    else:
        print("No changes made. All apps already have >= 200 features.")
