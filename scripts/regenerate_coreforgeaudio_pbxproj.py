import json
import os
from pathlib import Path

FEATURES_FILE = Path('features-phase8.json')
PBXPROJ_PATH = Path('apps/CoreForgeAudio/CoreForgeAudio.xcodeproj/project.pbxproj')


def load_features() -> list:
    data = json.loads(FEATURES_FILE.read_text())
    return data.get('phase8Features', {}).get('CoreForgeAudio', [])


def inject_features_block(text: str, features: list[str]) -> str:
    start_marker = '/* CoreForgeAudio Phase8 Features'
    if start_marker in text:
        # replace existing block
        pre, rest = text.split(start_marker, 1)
        _, post = rest.split('*/', 1)
        block = '\n'.join(f'- {f}' for f in features)
        return f"{pre}{start_marker}\n{block}\n*/{post}"
    else:
        block = '\n'.join(f'- {f}' for f in features)
        insert = f"{start_marker}\n{block}\n*/\n"
        lines = text.splitlines(True)
        if lines and lines[0].startswith('// !$*UTF8*$!'):
            return ''.join([lines[0], insert] + lines[1:])
        return insert + text


def main() -> None:
    features = load_features()
    text = PBXPROJ_PATH.read_text()
    new_text = inject_features_block(text, features)
    PBXPROJ_PATH.write_text(new_text)
    print(f'Updated {PBXPROJ_PATH}')


if __name__ == '__main__':
    main()
