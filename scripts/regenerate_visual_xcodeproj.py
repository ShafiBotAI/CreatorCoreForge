import json
from pathlib import Path

FEATURES_JSON = Path('features-phase8.json')
PROJECTS = [
    Path('apps/CoreForgeVisual/CoreForgeVisual.xcodeproj/project.pbxproj'),
    Path('apps/CoreForgeVisual/LoreForgeAIFull/LoreForgeAI.xcodeproj/project.pbxproj')
]


def update_project(path: Path, features: list[str]) -> None:
    text = path.read_text().splitlines()
    try:
        start = next(i for i,l in enumerate(text) if 'CoreForgeVisual Phase8 Features' in l)
        end = next(i for i in range(start+1, len(text)) if text[i] == '*/')
    except StopIteration:
        raise RuntimeError(f'Feature block not found in {path}')
    new_block = ['- ' + f for f in features]
    text[start+1:end] = new_block
    path.write_text('\n'.join(text) + '\n')


def main():
    data = json.loads(FEATURES_JSON.read_text())
    features = data['phase8Features']['CoreForgeVisual']
    for proj in PROJECTS:
        update_project(proj, features)
        print(f'Updated {proj}')


if __name__ == '__main__':
    main()
