import os
import re
import argparse
import json

# Define keywords to search for in code to match agent tasks
def extract_keywords(task: str):
    return re.findall(r'\b[a-zA-Z_]+\b', task.lower())


def scan_repo(repo_path: str):
    feature_results = {}
    for root, dirs, files in os.walk(repo_path):
        for file in files:
            if file.lower() == "agents.md":
                app_name = os.path.basename(root)
                with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                    lines = f.readlines()
                    features = [line.strip("- ").strip() for line in lines if "-" in line]
                feature_results[app_name] = {"implemented": [], "missing": []}
                # Combine all source code in this folder
                code_blob = ""
                for subroot, _, code_files in os.walk(root):
                    for code_file in code_files:
                        if code_file.endswith((
                            ".py",
                            ".js",
                            ".ts",
                            ".swift",
                            ".kt",
                            ".java",
                            ".cpp",
                        )):
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
    args = parser.parse_args()

    result = scan_repo(args.repo_path)

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
