import os
import re
import json
from collections import defaultdict

OUTPUT_DIR = os.path.join("generated", "progress")

try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False


def parse_open_tasks(filepath: str):
    app = None
    in_missing = False
    implemented = defaultdict(int)
    missing = defaultdict(int)
    tasks = defaultdict(list)
    package_emoji = "\U0001F4E6"  # 📦

    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            app_match = re.match(rf"^\s*{package_emoji} App: (.+)", line)
            if app_match:
                app = app_match.group(1).strip()
                in_missing = False
                continue
            if app is None:
                continue
            if line.startswith("✅"):
                m = re.search(r"(\d+)", line)
                if m:
                    implemented[app] = int(m.group(1))
                in_missing = False
                continue
            if line.startswith("❌"):
                m = re.search(r"(\d+)", line)
                if m:
                    missing[app] = int(m.group(1))
                in_missing = True
                continue
            if in_missing and line.strip().startswith("-"):
                tasks[app].append(line.strip().lstrip("- "))
                continue
            if not line.strip():
                in_missing = False

    return implemented, missing, tasks


def calc_progress(implemented: dict, missing: dict):
    progress = {}
    all_apps = set(implemented) | set(missing)
    for app in all_apps:
        done = implemented.get(app, 0)
        total = done + missing.get(app, 0)
        if total > 0:
            progress[app] = (done / total) * 100
        else:
            progress[app] = 0
    return progress


def print_progress(progress: dict):
    for app, percent in sorted(progress.items()):
        print(f"{app}: {percent:.1f}% complete")


def generate_code(task_description: str):
    if not OPENAI_AVAILABLE:
        raise RuntimeError("openai package not installed")
    api_key = os.getenv('OPENAI_API_KEY')
    if not api_key:
        raise RuntimeError('OPENAI_API_KEY environment variable not set')
    openai.api_key = api_key
    prompt = f"Write a code snippet to implement the following feature:\n{task_description}"
    resp = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=200
    )
    return resp.choices[0].message['content'].strip()


def offline_snippet(description: str) -> str:
    tokens = re.findall(r"[a-zA-Z_]+", description)[:5]
    name = sanitize("_".join(tokens).lower()) or "feature"
    return f"def {name}():\n    \"\"\"{description}\"\"\"\n    pass\n"


def sanitize(name: str) -> str:
    return re.sub(r"[^a-zA-Z0-9_]+", "_", name.strip()).strip("_") or "feature"


if __name__ == '__main__':
    tasks_file = os.path.join('docs', 'OPEN_TASKS.md')
    impl, miss, tasks = parse_open_tasks(tasks_file)
    progress = calc_progress(impl, miss)
    print("Current app progress:")
    print_progress(progress)

    if OPENAI_AVAILABLE and os.getenv('OPENAI_API_KEY'):
        print("\nGenerating code snippets for missing features...\n")
    else:
        print("\nOpenAI unavailable. Generating offline stubs...\n")
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    for app, items in tasks.items():
        app_dir = os.path.join(OUTPUT_DIR, sanitize(app))
        os.makedirs(app_dir, exist_ok=True)
        for feature in items:
            fname = sanitize(feature) + '.txt'
            fpath = os.path.join(app_dir, fname)
            if os.path.exists(fpath):
                continue
            try:
                snippet = generate_code(feature)
            except Exception:
                snippet = offline_snippet(feature)
            with open(fpath, 'w', encoding='utf-8') as out:
                out.write(f"# Auto-generated for {feature}\n{snippet}\n")
    print("\nCode snippets written to", OUTPUT_DIR)
