import os
import re
import argparse

TASK_RE = re.compile(r"^-\s*\[(x| )\]\s*(.+)", re.IGNORECASE)


def parse_file(path: str):
    total = 0
    done = 0
    with open(path, 'r', encoding='utf-8') as f:
        for line in f:
            m = TASK_RE.match(line.strip())
            if m:
                total += 1
                if m.group(1).lower() == 'x':
                    done += 1
    return done, total


def scan_apps(apps_dir: str):
    results = {}
    for root, dirs, files in os.walk(apps_dir):
        if 'AGENTS.md' in files:
            name = os.path.basename(root)
            if name.lower() == 'apps':
                continue  # skip aggregate AGENTS file
            path = os.path.join(root, 'AGENTS.md')
            done, total = parse_file(path)
            if total:
                results[name] = {'done': done, 'total': total}
    return results


def main():
    parser = argparse.ArgumentParser(description='Calculate app completion status from AGENTS.md tasks.')
    parser.add_argument('apps_dir', nargs='?', default='apps', help='Path to the apps directory')
    args = parser.parse_args()

    results = scan_apps(args.apps_dir)
    for app, data in sorted(results.items()):
        percent = (data['done'] / data['total']) * 100 if data['total'] else 0
        print(f"{app}: {data['done']}/{data['total']} ({percent:.1f}% complete)")


if __name__ == '__main__':
    main()
