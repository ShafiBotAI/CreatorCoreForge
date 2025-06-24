import os
import re
import json
from typing import Dict, List, Any

# Directories considered part of an app's standard structure
STANDARD_DIRS = ["components", "services", "hooks", "models", "views"]

# File extensions to scan for basic presence
FILE_EXTS = [".swift", ".ts", ".js", ".py", ".json", ".tsx"]

INCOMPLETE_PATTERNS = [
    re.compile(r"TODO", re.IGNORECASE),
    re.compile(r"pass\b"),
    re.compile(r"NotImplementedError"),
    re.compile(r"throw new Error\([^)]*not implemented[^)]*\)")
]

def scan_app(app_path: str) -> Dict[str, Any]:
    result: Dict[str, Any] = {
        "missing_dirs": [],
        "missing_file_types": [],
        "incomplete_files": []
    }

    # Check for standard directories
    for d in STANDARD_DIRS:
        if not os.path.isdir(os.path.join(app_path, d)):
            result["missing_dirs"].append(d)

    # Check presence of file types
    present_exts = set()
    for root, _, files in os.walk(app_path):
        for file in files:
            ext = os.path.splitext(file)[1]
            if ext in FILE_EXTS:
                present_exts.add(ext)
    for ext in FILE_EXTS:
        if ext not in present_exts:
            result["missing_file_types"].append(ext)

    # Scan for incomplete markers
    for root, _, files in os.walk(app_path):
        for file in files:
            if os.path.splitext(file)[1] in FILE_EXTS:
                path = os.path.join(root, file)
                try:
                    with open(path, "r", encoding="utf-8", errors="ignore") as f:
                        text = f.read()
                except Exception:
                    continue
                for pattern in INCOMPLETE_PATTERNS:
                    for m in pattern.finditer(text):
                        line_no = text[:m.start()].count("\n") + 1
                        snippet = text.splitlines()[line_no - 1].strip()
                        result["incomplete_files"].append({
                            "file": os.path.relpath(path, app_path),
                            "line": line_no,
                            "snippet": snippet
                        })
                        break
    return result

def scan_all(apps_dir: str) -> Dict[str, Any]:
    report: Dict[str, Any] = {}
    for name in os.listdir(apps_dir):
        app_path = os.path.join(apps_dir, name)
        if os.path.isdir(app_path):
            report[name] = scan_app(app_path)
    return report

if __name__ == "__main__":
    apps_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "apps")
    report = scan_all(apps_dir)
    with open(os.path.join(os.path.dirname(apps_dir), "full_app_scan_report.json"), "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2)
    print(f"Scan complete. Report written to full_app_scan_report.json")
