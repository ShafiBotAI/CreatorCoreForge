import json
import re
import sys
from pathlib import Path


def load_features(app_name: str, path: Path) -> list:
    data = json.loads(path.read_text())
    return data.get('phase8Features', {}).get(app_name, [])


def extract_features_block(text: str) -> list:
    m = re.search(r'/\*\s*CoreForgeVisual Phase8 Features\n(.*?)\*/', text, re.DOTALL)
    if not m:
        return []
    lines = [l.strip('- ').strip() for l in m.group(1).splitlines() if l.strip()]
    return lines


def main(pbxproj_path: str, json_path: str = 'features-phase8.json') -> int:
    path = Path(pbxproj_path)
    parts = path.parts
    try:
        apps_idx = parts.index('apps')
        app_name = parts[apps_idx + 1]
    except ValueError:
        app_name = path.parent.parent.name
    features = load_features(app_name, Path(json_path))
    text = path.read_text(errors='ignore')
    listed = extract_features_block(text)
    missing = [f for f in features if f not in listed]
    extra = [f for f in listed if f not in features]
    if missing or extra:
        print('Mismatch in features for', app_name)
        if missing:
            print('Missing:', len(missing))
        if extra:
            print('Extra:', len(extra))
        return 1
    print('Features verified for', app_name)
    return 0


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: verify_pbxproj_features.py <pbxproj path> [features file]')
        sys.exit(1)
    pbxproj = sys.argv[1]
    json_file = sys.argv[2] if len(sys.argv) > 2 else 'features-phase8.json'
    sys.exit(main(pbxproj, json_file))
