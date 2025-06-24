import os
import json
import re
import argparse

KEYWORDS = [
    "Content for",
    "TODO",
    "TBD",
    "Coming soon",
    "Mock",
    "Placeholder",
    "Sample",
    "Example",
]

def scan_file(path: str):
    occurrences = []
    total_lines = 0
    placeholder_lines = 0
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            for i, line in enumerate(f, 1):
                total_lines += 1
                for kw in KEYWORDS:
                    if kw.lower() in line.lower():
                        occurrences.append({"line": i, "keyword": kw, "content": line.strip()})
                        placeholder_lines += 1
                        break
    except Exception:
        return None
    pct = placeholder_lines / total_lines if total_lines else 0
    return total_lines, pct, occurrences


def scan_repo(repo_root: str, extensions=None):
    if extensions is None:
        extensions = [
            '.py', '.js', '.ts', '.tsx', '.swift', '.kt', '.java',
            '.md', '.json', '.yml', '.yaml'
        ]
    results = {}
    for root, dirs, files in os.walk(repo_root):
        if '.git' in dirs:
            dirs.remove('.git')
        for name in files:
            if any(name.endswith(ext) for ext in extensions):
                path = os.path.join(root, name)
                res = scan_file(path)
                if res is None:
                    continue
                total, pct, occ = res
                if occ:
                    rel = os.path.relpath(path, repo_root)
                    results[rel] = {
                        'total_lines': total,
                        'placeholder_percentage': pct,
                        'flagged': pct >= 0.5,
                        'occurrences': occ,
                    }
    return results


def main():
    parser = argparse.ArgumentParser(description='Scan repo for placeholder keywords')
    parser.add_argument('path', nargs='?', default='.', help='Repository root')
    args = parser.parse_args()

    result = scan_repo(os.path.abspath(args.path))
    with open('placeholder_scan_report.json', 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2)
    print(f'Scanned {len(result)} files. Report written to placeholder_scan_report.json')

if __name__ == '__main__':
    main()
