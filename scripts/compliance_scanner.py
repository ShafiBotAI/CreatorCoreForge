import os
import re
import json

IGNORE_DIRS = {'.git', 'node_modules', 'generated', 'dist', '__pycache__'}
FILE_EXTS = {'.swift', '.ts', '.js', '.py', '.tsx'}

FUNC_PATTERNS = [
    re.compile(r'func\s+(\w+)'),
    re.compile(r'def\s+(\w+)'),
    re.compile(r'function\s+(\w+)'),
    re.compile(r'(\w+)\s*=\s*\([^)]*\)\s*=>')
]

ISSUES = [
    ('empty_function', re.compile(r'\{\s*\}')),  # {} body
    ('return_nil', re.compile(r'return\s+(nil|null)\b')),
    ('todo_comment', re.compile(r'TODO')), 
    ('not_implemented', re.compile(r'NotImplementedError')),
]

FETCH_PATTERN = re.compile(r'fetch\(')


def find_function_name(lines, idx):
    for i in range(idx, -1, -1):
        line = lines[i]
        for pat in FUNC_PATTERNS:
            m = pat.search(line)
            if m:
                return m.group(1)
    return 'unknown'


def scan_file(path):
    issues = []
    try:
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except Exception:
        return issues
    for i, line in enumerate(lines):
        for name, pat in ISSUES:
            if pat.search(line):
                func = find_function_name(lines, i)
                issues.append({'line': i + 1, 'function': func, 'issue': name})
        if FETCH_PATTERN.search(line) and '.catch' not in ''.join(lines[i:i+3]):
            func = find_function_name(lines, i)
            issues.append({'line': i + 1, 'function': func, 'issue': 'fetch_no_error_handling'})
    return issues



def scan_repo(root):
    report = {}
    for dirpath, dirs, files in os.walk(root):
        dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]
        for fname in files:
            if os.path.splitext(fname)[1] in FILE_EXTS:
                path = os.path.join(dirpath, fname)
                result = scan_file(path)
                if result:
                    report[os.path.relpath(path, root)] = result
    return report


if __name__ == '__main__':
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    report = scan_repo(repo_root)
    with open(os.path.join(repo_root, 'compliance_scan_report.json'), 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2)
    print(f'Scan complete. {len(report)} files with issues found.')
