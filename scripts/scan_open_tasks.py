import os
import re
import json
import argparse

TASK_PATTERN = re.compile(r'^\s*- \[ \] (.+)')

def scan_markdown(path):
    tasks = []
    with open(path, 'r', encoding='utf-8') as f:
        for lineno, line in enumerate(f, 1):
            m = TASK_PATTERN.match(line)
            if m:
                tasks.append({
                    'file': path,
                    'line': lineno,
                    'task': m.group(1).strip()
                })
    return tasks

def main():
    parser = argparse.ArgumentParser(description='Scan markdown files for unchecked tasks')
    parser.add_argument('root', nargs='?', default='.')
    parser.add_argument('-o', '--output', default='remaining_tasks_map.json')
    args = parser.parse_args()

    root = os.path.abspath(args.root)
    tasks = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d != '.git']
        for fname in filenames:
            if fname.lower().endswith('.md'):
                path = os.path.join(dirpath, fname)
                tasks.extend(scan_markdown(path))

    output = {'tasks': tasks}
    with open(args.output, 'w', encoding='utf-8') as f:
        json.dump(output, f, indent=2)
    print(f'Found {len(tasks)} tasks')

if __name__ == '__main__':
    main()
