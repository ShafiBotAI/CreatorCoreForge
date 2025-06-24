import os

for root, dirs, files in os.walk('.'):
    if 'AGENTS.md' in files:
        path = os.path.join(root, 'AGENTS.md')
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        count = 0
        out = []
        skip = False
        for line in lines:
            if line.startswith('### Phase Features Summary'):
                count += 1
                if count > 1:
                    skip = True
            if not skip:
                out.append(line)
            if skip and line.strip() == '':
                skip = False
        if count > 1:
            with open(path, 'w', encoding='utf-8') as f:
                f.writelines(out)
            print('Cleaned', path)
