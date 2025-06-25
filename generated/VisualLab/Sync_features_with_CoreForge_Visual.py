# Auto-generated for Sync features with CoreForge Visual
import json
from pathlib import Path


def sync_features_with(json_path: str = "features-phase8.json") -> Path:
    """Sync CoreForge Visual features into VisualLab/features.json.

    Loads the Phase 8 feature list and writes the CoreForge Visual section
    to ``VisualLab/features.json`` for convenient reference.
    Returns the path to the generated file.
    """
    features_file = Path(json_path)
    if not features_file.exists():
        raise FileNotFoundError(features_file)

    with features_file.open("r", encoding="utf-8") as f:
        data = json.load(f)

    visual_features = data.get("phase8Features", {}).get("CoreForgeVisual", [])
    out_path = Path("VisualLab/features.json")
    out_path.write_text(json.dumps(visual_features, indent=2), encoding="utf-8")
    return out_path
