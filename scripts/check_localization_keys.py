import json
import os
import sys

BASE = 'locales'
files = [f for f in os.listdir(BASE) if f.endswith('.json')]

if 'en.json' not in files:
    print('Missing en.json localization file')
    sys.exit(1)

with open(os.path.join(BASE, 'en.json'), 'r', encoding='utf-8') as f:
    base_keys = set(json.load(f).keys())

fail = False
for file in files:
    path = os.path.join(BASE, file)
    with open(path, 'r', encoding='utf-8') as f:
        keys = set(json.load(f).keys())
    missing = base_keys - keys
    if missing:
        print(f'{file} missing keys: {missing}')
        fail = True

if fail:
    sys.exit(1)
print('Localization keys validated')
