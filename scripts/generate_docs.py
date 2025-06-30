import os
import re
from pathlib import Path

SRC_DIRS = ['Sources', 'apps']
OUT_DIR = Path('generated/docs')
OUT_DIR.mkdir(parents=True, exist_ok=True)

def extract_signatures(file_path):
    sigs = []
    for line in open(file_path, 'r', encoding='utf-8'):
        m = re.match(r'\s*(public|func|class|struct).*', line)
        if m:
            sigs.append(line.strip())
    return sigs

def process_dir(directory):
    for root, _, files in os.walk(directory):
        for f in files:
            if f.endswith('.swift') or f.endswith('.js'):
                fp = Path(root) / f
                sigs = extract_signatures(fp)
                if sigs:
                    out = OUT_DIR / (fp.name + '.md')
                    with open(out, 'w', encoding='utf-8') as md:
                        md.write('# API Stubs for ' + fp.name + '\n')
                        for s in sigs:
                            md.write('## ' + s + '\n\n')

for d in SRC_DIRS:
    if os.path.exists(d):
        process_dir(d)
print('Doc stubs generated in', OUT_DIR)
