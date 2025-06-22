import os
import re
import json
from collections import defaultdict

try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False


def parse_open_tasks(filepath: str):
    app = None
    implemented = defaultdict(int)
    missing = defaultdict(int)
    package_emoji = "\U0001F4E6"  # 📦
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            app_match = re.match(rf'^\s*{package_emoji} App: (.+)', line)
            if app_match:
                app = app_match.group(1).strip()
                continue
            if app is None:
                continue
            if line.startswith('✅'):
                # The line may contain the number of implemented features
                m = re.search(r'(\d+)', line)
                if m:
                    implemented[app] = int(m.group(1))
                continue
            if line.startswith('❌'):
                m = re.search(r'(\d+)', line)
                if m:
                    missing[app] = int(m.group(1))
                continue
    return implemented, missing


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


if __name__ == '__main__':
    tasks_file = os.path.join('docs', 'OPEN_TASKS.md')
    impl, miss = parse_open_tasks(tasks_file)
    progress = calc_progress(impl, miss)
    print("Current app progress:")
    print_progress(progress)

    if OPENAI_AVAILABLE and os.getenv('OPENAI_API_KEY'):
        # Example usage for the first missing task of the first app
        with open(tasks_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        current_app = None
        for line in lines:
            app_match = re.match(r'^\s*\xf0\x9f\x93\xa6 App: (.+)', line)
            if app_match:
                current_app = app_match.group(1).strip()
                continue
            if current_app and line.strip().startswith('-') and 'Incomplete' not in line:
                description = line.strip(' -\n')
                print(f"\nSuggesting code for {current_app}: {description}")
                try:
                    snippet = generate_code(description)
                    print(snippet)
                except Exception as e:
                    print(f"Could not generate code: {e}")
                break
    else:
        print("\nInstall openai package and set OPENAI_API_KEY to generate code suggestions.")
