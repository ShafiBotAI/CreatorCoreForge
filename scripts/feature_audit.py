import os
import re
import argparse
import json

# Define keywords to search for in code to match agent tasks
def extract_keywords(task: str):
    """Return a list of keyword tokens for a feature task."""
    return re.findall(r"\b[a-zA-Z_]+\b", task.lower())


def parse_features(lines):
    """Parse feature/task lines from an AGENTS.md file.

    This function supports both bullet lists and checkbox style tasks.
    Returns a list of feature descriptions.
    """
    features = []
    checkbox = re.compile(r"^-\s*\[[x ]\]\s*(.+)", re.IGNORECASE)
    bullet = re.compile(r"^-\s+(?!\[)(.+)")

    for line in lines:
        line = line.strip()
        m = checkbox.match(line)
        if m:
            features.append(m.group(1).strip())
            continue
        m = bullet.match(line)
        if m:
            features.append(m.group(1).strip())
    return features


def scan_repo(repo_path: str, extensions=None, ignore_dirs=None):
    """Scan the repo and check each AGENTS.md feature against source code."""
    if extensions is None:
        extensions = [".py", ".js", ".ts", ".swift", ".kt", ".java", ".cpp"]
    if ignore_dirs is None:
        ignore_dirs = []

    feature_results = {}
    for root, dirs, files in os.walk(repo_path):
        # Skip ignored directories
        dirs[:] = [d for d in dirs if os.path.join(root, d) not in ignore_dirs]
        for file in files:
            if file.lower() == "agents.md":
                app_name = os.path.basename(root)
                with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                    lines = f.readlines()
                    features = parse_features(lines)
                feature_results[app_name] = {"implemented": [], "missing": []}
                # Combine all source code in this folder
                code_blob = ""
                for subroot, _, code_files in os.walk(root):
                    for code_file in code_files:
                        if any(code_file.endswith(ext) for ext in extensions):
                            try:
                                with open(
                                    os.path.join(subroot, code_file),
                                    "r",
                                    encoding="utf-8",
                                ) as cf:
                                    code_blob += cf.read().lower()
                            except Exception:
                                continue
                for feature in features:
                    keywords = extract_keywords(feature)
                    found = all(
                        kw in code_blob for kw in keywords if len(kw) > 3
                    )
                    if found:
                        feature_results[app_name]["implemented"].append(feature)
                    else:
                        feature_results[app_name]["missing"].append(feature)
    return feature_results


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Scan repository code to match tasks from AGENTS.md files"
    )
    parser.add_argument(
        "repo_path",
        help="Path to the root of the CreatorCoreForge repo",
    )
    parser.add_argument(
        "-e",
        "--extensions",
        default="py,js,ts,swift,kt,java,cpp",
        help="Comma-separated list of file extensions to scan",
    )
    parser.add_argument(
        "-i",
        "--ignore",
        action="append",
        default=[],
        help="Directories to ignore during scanning",
    )
    args = parser.parse_args()

    ext_list = [
        "." + e.strip().lstrip(".")
        for e in args.extensions.split(",")
        if e.strip()
    ]
    ignore_dirs = [os.path.abspath(d) for d in args.ignore]

    result = scan_repo(args.repo_path, extensions=ext_list, ignore_dirs=ignore_dirs)

    print("\n\U0001F9E0 FEATURE IMPLEMENTATION REPORT\n")
    for app, data in result.items():
        print(f"\U0001F4E6 App: {app}")
        print(f"\u2705 Implemented Features: {len(data['implemented'])}")
        for feat in data["implemented"]:
            print(f"   - {feat}")
        print(f"\n❌ Missing or Incomplete Features: {len(data['missing'])}")
        for feat in data["missing"]:
            print(f"   - {feat}")
        print("\n" + "=" * 50 + "\n")

    with open("feature_audit_report.json", "w", encoding="utf-8") as out_file:
        json.dump(result, out_file, indent=2)
