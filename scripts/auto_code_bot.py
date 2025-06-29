import os
import re
import py_compile
from typing import List, Dict
from datetime import datetime

try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False

from feature_audit import scan_repo
from stub_helper import scan_repo as scan_stubs, FILE_EXTS
import argparse


def parse_tasks_file(path: str) -> List[str]:
    """Return a list of task descriptions from a plain text file."""
    tasks: List[str] = []
    try:
        with open(path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip().lstrip("- ")
                if line:
                    tasks.append(line)
    except Exception:
        pass
    return tasks


TODO_PATTERN = re.compile(r"TODO[:\s]*(.*)", re.IGNORECASE)


def offline_snippet(description: str, ext: str) -> str:
    """Return a language-aware placeholder snippet.

    The logic attempts to create slightly more useful code templates when
    running without OpenAI access.  Simple heuristics detect whether a task
    describes a CLI script, an HTTP service, or a small data registry and
    returns a fitting skeleton instead of a bare ``pass`` statement.
    """
    tokens = re.findall(r"[a-zA-Z_]+", description)[:3]
    base = sanitize("_".join(tokens).lower()) or "feature"
    lower = description.lower()

    if ext == ".swift" or "swift" in lower:
        return f"func {base}() {{\n    // {description}\n}}\n"
    if ext == ".kt" or "kotlin" in lower:
        return f"fun {base}() {{\n    // {description}\n}}\n"
    if ext == ".ts" or "typescript" in lower or "javascript" in lower:
        return f"export function {base}() {{\n  // {description}\n}}\n"

    if ext == ".py":
        if any(k in lower for k in ["cli", "script", "command line", "steps"]):
            return (
                "import argparse\n\n"
                f"def main():\n"
                f"    \"\"\"{description}\"\"\"\n"
                "    parser = argparse.ArgumentParser(description=\""" + description + "\")\n"
                "    parser.add_argument('--verbose', action='store_true')\n"
                "    args = parser.parse_args()\n"
                "    print('Running', args)\n\n"
                "if __name__ == '__main__':\n"
                "    main()\n"
            )
        if any(k in lower for k in ["server", "http", "api"]):
            return (
                "from flask import Flask, jsonify\n\n"
                f"app = Flask(__name__)\n\n"
                f"@app.route('/{base}', methods=['GET'])\n"
                f"def {base}():\n"
                f"    \"\"\"{description}\"\"\"\n"
                "    return jsonify(status='ok')\n\n"
                "if __name__ == '__main__':\n"
                "    app.run(debug=True)\n"
            )
        if "contact" in lower:
            return (
                "CONTACTS = {}\n\n"
                "def add_contact(name: str, email: str) -> None:\n"
                "    CONTACTS[name] = email\n\n"
                "def get_contact(name: str) -> str | None:\n"
                "    return CONTACTS.get(name)\n"
            )

    if "class" in lower:
        class_name = base.title().replace("_", "")
        return (
            f"class {class_name}:\n"
            f"    \"\"\"{description}\"\"\"\n\n"
            f"    def __init__(self):\n        pass\n"
        )
    if any(k in lower for k in ["async", "http", "server"]):
        return (
            f"async def {base}():\n"
            f"    \"\"\"{description}\"\"\"\n"
            f"    pass\n"
        )

    return f"def {base}():\n    \"\"\"{description}\"\"\"\n    pass\n"


def sanitize(name: str) -> str:
    """Return a filesystem-safe name."""
    return re.sub(r"[^a-zA-Z0-9_]+", "_", name.strip()).strip("_") or "feature"


def determine_extension(description: str) -> str:
    """Return an appropriate file extension based on keywords."""
    lower = description.lower()
    if "swift" in lower:
        return ".swift"
    if "kotlin" in lower:
        return ".kt"
    if "typescript" in lower or "javascript" in lower:
        return ".ts"
    return ".py"


def language_from_extension(ext: str) -> str:
    """Map a file extension to a language name for the output directory."""
    mapping = {
        ".py": "python",
        ".ts": "javascript",
        ".js": "javascript",
        ".swift": "swift",
        ".kt": "kotlin",
    }
    return mapping.get(ext, "misc")


def scan_todo_comments(repo_root: str) -> Dict[str, List[Dict[str, object]]]:
    """Return mapping of file -> list of TODO comment info."""
    results: Dict[str, List[Dict[str, object]]] = {}
    for root, dirs, files in os.walk(repo_root):
        if '.git' in dirs:
            dirs.remove('.git')
        for name in files:
            ext = os.path.splitext(name)[1]
            if ext in FILE_EXTS:
                path = os.path.join(root, name)
                try:
                    with open(path, 'r', encoding='utf-8') as f:
                        lines = f.readlines()
                except Exception:
                    continue
                todos: List[Dict[str, object]] = []
                for i, line in enumerate(lines, 1):
                    m = TODO_PATTERN.search(line)
                    if m:
                        desc = m.group(1).strip() or 'implement logic'
                        todos.append({'line': i, 'desc': desc})
                if todos:
                    results[os.path.relpath(path, repo_root)] = todos
    return results


def replace_todo_comments(repo_root: str) -> None:
    todo_map = scan_todo_comments(repo_root)
    for rel, items in todo_map.items():
        path = os.path.join(repo_root, rel)
        try:
            with open(path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
        except Exception:
            continue
        ext = os.path.splitext(path)[1]
        offset = 0
        for item in items:
            idx = item['line'] - 1 + offset
            desc = item['desc']
            snippet = generate_snippet(desc, ext)
            indent = re.match(r'\s*', lines[idx]).group(0)
            snippet_lines = [indent + s + '\n' for s in snippet.splitlines()]
            lines[idx:idx + 1] = snippet_lines
            offset += len(snippet_lines) - 1
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(lines)


def replace_stub_code(repo_root: str) -> None:
    report = scan_stubs(repo_root)
    for rel, detections in report.items():
        path = os.path.join(repo_root, rel)
        try:
            with open(path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
        except Exception:
            continue
        ext = os.path.splitext(path)[1]
        offset = 0
        for det in sorted(detections, key=lambda d: d['line']):
            idx = det['line'] - 1 + offset
            desc = det['type'].replace('_', ' ')
            snippet = generate_snippet(desc, ext)
            indent = re.match(r'\s*', lines[idx]).group(0)
            snippet_lines = [indent + s + '\n' for s in snippet.splitlines()]
            lines[idx:idx + 1] = snippet_lines
            offset += len(snippet_lines) - 1
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(lines)


def save_output_snippet(base_path: str, feature: str, ext: str, snippet: str) -> None:
    """Save the snippet in /output/<language> with a timestamp."""
    language = language_from_extension(ext)
    output_dir = os.path.join(base_path, "output", language)
    os.makedirs(output_dir, exist_ok=True)
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    fname = f"{sanitize(feature)}_{timestamp}{ext}"
    out_path = os.path.join(output_dir, fname)
    with open(out_path, "w", encoding="utf-8") as out:
        out.write(f"# Auto-generated for {feature}\n")
        out.write(snippet)


def generate_snippet(description: str, ext: str) -> str:
    """Generate a code snippet using OpenAI or fallback offline mode."""
    if OPENAI_AVAILABLE and os.getenv("OPENAI_API_KEY"):
        api_key = os.getenv("OPENAI_API_KEY")
        openai.api_key = api_key
        prompt = (
            "Write a concise code snippet for the following feature in the corresponding language:\n"
            f"{description}\n"
        )
        try:
            resp = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[{"role": "user", "content": prompt}],
                max_tokens=200,
            )
            return resp.choices[0].message["content"].strip() + "\n"
        except Exception:
            return offline_snippet(description, ext)
    else:
        return offline_snippet(description, ext)


def fix_python_file(path: str) -> bool:
    """Attempt a minimal offline fix for a Python file.

    Currently this just comments out the line causing a SyntaxError so the
    file can be imported without crashing.
    Returns True if the file was valid or fixed, False otherwise.
    """
    try:
        py_compile.compile(path, doraise=True)
        return True
    except py_compile.PyCompileError as e:
        lineno = getattr(e.exc_value, 'lineno', None)
        if lineno is None:
            return False
        try:
            with open(path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            if 0 <= lineno - 1 < len(lines):
                lines[lineno - 1] = '# AUTO_FIX: ' + lines[lineno - 1]
                with open(path, 'w', encoding='utf-8') as f:
                    f.writelines(lines)
                return True
        except Exception:
            return False
        return False


def fix_repo_code(repo_path: str) -> None:
    """Scan and attempt offline fixes for Python files."""
    for root, _, files in os.walk(repo_path):
        for name in files:
            if name.endswith('.py'):
                path = os.path.join(root, name)
                fix_python_file(path)


def create_files(repo_path: str, extra_tasks: List[str] | None = None) -> None:
    result = scan_repo(repo_path)
    gen_root = os.path.join(repo_path, "generated")
    os.makedirs(gen_root, exist_ok=True)

    for app, data in result.items():
        missing: List[str] = data.get("missing", [])
        if not missing:
            continue
        app_dir = os.path.join(gen_root, sanitize(app))
        os.makedirs(app_dir, exist_ok=True)
        for feature in missing:
            ext = determine_extension(feature)
            fname = sanitize(feature) + ext
            fpath = os.path.join(app_dir, fname)
            if os.path.exists(fpath):
                continue
            snippet = generate_snippet(feature, ext)
            with open(fpath, "w", encoding="utf-8") as f:
                f.write(f"# Auto-generated for {feature}\n")
                f.write(snippet)
            save_output_snippet(repo_path, feature, ext, snippet)

    if extra_tasks:
        manual_dir = os.path.join(gen_root, "manual")
        os.makedirs(manual_dir, exist_ok=True)
        for feature in extra_tasks:
            ext = determine_extension(feature)
            fname = sanitize(feature) + ext
            fpath = os.path.join(manual_dir, fname)
            if os.path.exists(fpath):
                continue
            snippet = generate_snippet(feature, ext)
            with open(fpath, "w", encoding="utf-8") as f:
                f.write(f"# Auto-generated for {feature}\n")
                f.write(snippet)


def _parse_placeholder_line(line: str) -> str | None:
    match = re.search(r"Auto-generated for\s+(.*)", line)
    if match:
        return match.group(1).strip()
    return None


def upgrade_placeholders(gen_root: str) -> None:
    for root, _, files in os.walk(gen_root):
        for name in files:
            path = os.path.join(root, name)
            try:
                with open(path, "r", encoding="utf-8") as f:
                    first = f.readline()
            except Exception:
                continue
            feature = _parse_placeholder_line(first)
            if not feature:
                continue
            ext = os.path.splitext(name)[1]
            snippet = generate_snippet(feature, ext)
            with open(path, "w", encoding="utf-8") as f:
                f.write(first)
                f.write(snippet)
            base_repo = os.path.abspath(os.path.join(gen_root, ".."))
            save_output_snippet(base_repo, feature, ext, snippet)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate or upgrade placeholder code files")
    parser.add_argument(
        "--upgrade-placeholders",
        action="store_true",
        help="Replace existing placeholders in the generated folder using OpenAI",
    )
    parser.add_argument(
        "--complete-todos",
        action="store_true",
        help="Replace TODO comments with generated code",
    )
    parser.add_argument(
        "--complete-stubs",
        action="store_true",
        help="Replace simple stubs with generated code",
    )
    parser.add_argument(
        "--tasks-file",
        help="Optional text file containing additional tasks to generate code for",
    )
    args = parser.parse_args()

    repo = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

    extra = parse_tasks_file(args.tasks_file) if args.tasks_file else None

    if args.upgrade_placeholders:
        upgrade_placeholders(os.path.join(repo, "generated"))
    else:
        create_files(repo, extra_tasks=extra)

    if args.complete_todos:
        replace_todo_comments(repo)
    if args.complete_stubs:
        replace_stub_code(repo)

    fix_repo_code(repo)
    print("Auto code generation complete. Check the 'generated' and 'output' folders.")
