import os
import re
import json
import argparse
from typing import List, Dict

LOOP_PATTERN = re.compile(r'\b(for|while)\b')
NETWORK_PATTERN = re.compile(r'\b(fetch|axios\.get|URLSession\.shared\.dataTask)')


def scan_file(path: str) -> List[Dict[str, object]]:
    findings = []
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
    except Exception:
        return findings

    loop_indices = []
    for idx, line in enumerate(lines):
        if LOOP_PATTERN.search(line):
            loop_indices.append(idx)

    for i in range(len(loop_indices) - 1):
        if loop_indices[i + 1] - loop_indices[i] <= 5:
            findings.append({
                'line': loop_indices[i] + 1,
                'optimization': 'nested_loop',
                'suggestion': 'Consider refactoring nested loops'
            })
            break

    for idx, line in enumerate(lines):
        if NETWORK_PATTERN.search(line) and 'await' not in line:
            findings.append({
                'line': idx + 1,
                'optimization': 'blocking_network_call',
                'suggestion': 'Use async calls or background tasks'
            })

    return findings


def scan_repo(root: str, extensions=None) -> Dict[str, List[Dict[str, object]]]:
    if extensions is None:
        extensions = ['.ts', '.tsx', '.js', '.py', '.swift']
    report: Dict[str, List[Dict[str, object]]] = {}
    for dirpath, _, filenames in os.walk(root):
        if '.git' in dirpath.split(os.sep):
            continue
        for fname in filenames:
            if any(fname.endswith(ext) for ext in extensions):
                path = os.path.join(dirpath, fname)
                findings = scan_file(path)
                if findings:
                    rel = os.path.relpath(path, root)
                    report[rel] = findings
    return report


def main():
    parser = argparse.ArgumentParser(description='Scan repository for basic performance issues')
    parser.add_argument('path', nargs='?', default='.')
    parser.add_argument('-o', '--output', default='performance_scan_report.json')
    args = parser.parse_args()

    report = scan_repo(os.path.abspath(args.path))
    with open(args.output, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2)
    print(f'Scan complete. {len(report)} files with findings.')


if __name__ == '__main__':
    main()
