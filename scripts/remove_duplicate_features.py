import json
from pathlib import Path

path = Path('features-phase8.json')
text = path.read_text()

clean_lines = []
for line in text.splitlines():
    stripped = line.strip()
    if stripped.startswith(('<', '>', '=', '<<<<<<<', '>>>>>>>')):
        continue
    clean_lines.append(line)
clean_text = '\n'.join(clean_lines)

try:
    data = json.loads(clean_text)
except json.JSONDecodeError as e:
    raise SystemExit(f'JSON parse error: {e}')

for section, features in data.get('phase8Features', {}).items():
    if isinstance(features, list):
        seen = set()
        deduped = []
        for item in features:
            if item not in seen:
                seen.add(item)
                deduped.append(item)
        data['phase8Features'][section] = deduped

path.write_text(json.dumps(data, indent=2))
print('features-phase8.json cleaned and deduplicated')
