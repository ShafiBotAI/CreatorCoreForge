import os
import re
import json
import argparse
from typing import List, Dict

PATTERNS = [
    (re.compile(r"TODO", re.IGNORECASE), "TODO placeholder"),
    (re.compile(r"\bpass\b"), "pass statement"),
    (re.compile(r"return\s+nil"), "return nil"),
    (re.compile(r"return\s+None"), "return None"),
    (re.compile(r"fatalError\(\"Not implemented\"\)"), "fatalError Not implemented"),
]


def _detect_empty_functions(lines: List[str]) -> List[Dict[str, object]]:
    findings: List[Dict[str, object]] = []
    for idx, line in enumerate(lines):
        if re.match(r"^\s*def\s+\w+\(.*\):\s*$", line):
            j = idx + 1
            while j < len(lines) and lines[j].strip() == "":
                j += 1
            if j >= len(lines) or re.match(r"^\s*(pass|return\s+None|\.\.\.)\s*$", lines[j]):
                findings.append({
                    "line": idx + 1,
                    "issue": "empty python function",
                    "content": line.strip(),
                })
        if re.match(r"^\s*func\s+\w+\(.*\)\s*\{\s*\}\s*$", line):
            findings.append({
                "line": idx + 1,
                "issue": "empty swift function",
                "content": line.strip(),
            })
    return findings


def scan_file(path: str) -> List[Dict[str, object]]:
    findings: List[Dict[str, object]] = []
    try:
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            lines = f.readlines()
    except Exception:
        return findings

    for idx, line in enumerate(lines, 1):
        for pattern, label in PATTERNS:
            if pattern.search(line):
                findings.append({
                    "line": idx,
                    "issue": label,
                    "content": line.strip(),
                })
                break

    findings.extend(_detect_empty_functions(lines))
    return findings


def scan_repo(root: str, extensions=None) -> Dict[str, List[Dict[str, object]]]:
    if extensions is None:
        extensions = [
            ".py", ".swift", ".ts", ".tsx", ".js", ".kt",
        ]
    report: Dict[str, List[Dict[str, object]]] = {}
    for dirpath, _, filenames in os.walk(root):
        if ".git" in dirpath.split(os.sep):
            continue
        for name in filenames:
            if any(name.endswith(ext) for ext in extensions):
                path = os.path.join(dirpath, name)
                detections = scan_file(path)
                if detections:
                    rel = os.path.relpath(path, root)
                    report[rel] = detections
    return report


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Scan repository for weak or placeholder code patterns"
    )
    parser.add_argument("path", nargs="?", default=".", help="Repository root")
    parser.add_argument(
        "-o",
        "--output",
        default="weak_code_report.json",
        help="Output JSON file",
    )
    args = parser.parse_args()
    root = os.path.abspath(args.path)
    report = scan_repo(root)
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2)
    print(f"Scan complete. {len(report)} files with potential issues.")


if __name__ == "__main__":
    main()
