import os
import re
import json
import argparse

PATTERNS = [
    ("python_empty_function", r"def\s+\w+\([^)]*\):\s*\n\s*pass\b"),
    ("raise_not_implemented", r"raise\s+NotImplementedError"),
    ("throw_not_implemented", r"throw\s+new\s+Error\([^\)]*not implemented[^\)]*\)"),
    ("empty_braces_function", r"func\s+\w+\([^)]*\)\s*\{\s*\}"),
    # Only flag a stub if the entire line is just `return nil` or `return null`.
    ("return_nil_or_null", r"^\s*return\s+(nil|null)\s*$"),
    ("stub_comment", r"//\s*stub\b"),
]

IGNORE_DIRS = {'.git', 'node_modules', 'generated'}
IGNORE_FILES = {'stub_helper.py'}
FILE_EXTS = {'.py', '.js', '.ts', '.swift', '.kt', '.java'}


def scan_file(path: str):
    """Return list of (line_number, pattern_name)."""
    detections = []
    try:
        with open(path, 'r', encoding='utf-8') as f:
            text = f.read()
    except Exception:
        return detections

    for name, pat in PATTERNS:
        for m in re.finditer(pat, text, re.MULTILINE):
            line_no = text[:m.start()].count('\n') + 1
            detections.append((line_no, name))
    return detections


def replace_stubs(path: str, detections):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except Exception:
        return

    for line_no, det in sorted(detections, reverse=True):
        idx = line_no - 1
        if idx < 0 or idx >= len(lines):
            continue
        line = lines[idx]
        if det in {"python_empty_function", "raise_not_implemented"}:
            if 'pass' in line:
                lines[idx] = line.replace('pass', 'raise NotImplementedError')
            else:
                lines[idx] = line.rstrip() + '  # TODO: implement\n'
        elif det == "throw_not_implemented":
            lines[idx] = re.sub(r'not implemented', 'TODO: implement', line)
        elif det == "empty_braces_function":
            lines[idx] = re.sub(r'\{\s*\}', '{\n    // TODO: implement\n}', line)
        elif det == "return_nil_or_null":
            lines[idx] = line.rstrip() + '  // TODO: return real value\n'
        elif det == "stub_comment":
            lines[idx] = line.rstrip() + ' TODO\n'
    try:
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(lines)
    except Exception:
        pass


def scan_repo(repo_root: str):
    report = {}
    for root, dirs, files in os.walk(repo_root):
        dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]
        for fname in files:
            if fname in IGNORE_FILES:
                continue
            if os.path.splitext(fname)[1] in FILE_EXTS:
                path = os.path.join(root, fname)
                detections = scan_file(path)
                if detections:
                    rel = os.path.relpath(path, repo_root)
                    report[rel] = [
                        {"line": ln, "type": det} for ln, det in detections
                    ]
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Scan for stub implementations and optionally replace them"
    )
    parser.add_argument(
        "--replace",
        action="store_true",
        help="Replace detected stubs with TODO comments",
    )
    args = parser.parse_args()
    repo = os.path.abspath(os.path.dirname(__file__))

    results = scan_repo(repo)
    if args.replace:
        for rel_path, dets in results.items():
            replace_stubs(os.path.join(repo, rel_path), [(d['line'], d['type']) for d in dets])
    with open(os.path.join(repo, 'stub_scan_report.json'), 'w', encoding='utf-8') as out:
        json.dump(results, out, indent=2)
    print(f"Scan complete. {len(results)} files with stubs found.")
