import os
import re
import json

# Load features-phase8.json if exists
features = {}
try:
    with open('features-phase8.json') as f:
        data = json.load(f)
        features = data.get('phase8Features', {})
except Exception as e:
    pass

def extract_bullets(readme_path, limit=5):
    bullets = []
    if not os.path.exists(readme_path):
        return bullets
    with open(readme_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line.startswith('- '):
                bullets.append(line[2:].strip())
            elif line.startswith(' - '):
                bullets.append(line[3:].strip())
            if len(bullets) >= limit:
                break
    return bullets

for root, dirs, files in os.walk('.'):    
    if 'AGENTS.md' in files:
        agents_path = os.path.join(root, 'AGENTS.md')
        readme_path = os.path.join(root, 'README.md')
        app_name = os.path.basename(root)
        bullets = extract_bullets(readme_path)
        phase_features = features.get(app_name, [])[:5]
        lines = ["\n### Phase Features Summary"]
        if bullets:
            lines.append('Key points from `README.md`:')
            for b in bullets:
                lines.append(f'- {b}')
        elif phase_features:
            lines.append('Highlights from `features-phase8.json`:')
            for ftr in phase_features:
                lines.append(f'- {ftr}')
        else:
            lines.append('- Refer to README for details.')
        with open(agents_path, 'a', encoding='utf-8') as f:
            f.write('\n'.join(lines) + '\n')
        print(f'Updated {agents_path}')
