import os
import re
import py_compile
from typing import List

try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False

from feature_audit import scan_repo
import argparse


def offline_snippet(description: str, ext: str) -> str:
    """Return a language-aware placeholder snippet."""
    tokens = re.findall(r"[a-zA-Z_]+", description)[:3]
    base = sanitize("_".join(tokens).lower()) or "feature"
    lower = description.lower()

    if ext == ".swift" or "swift" in lower:
        return f"func {base}() {{\n    // {description}\n}}\n"
    if ext == ".kt" or "kotlin" in lower:
        return f"fun {base}() {{\n    // {description}\n}}\n"
    if ext == ".ts" or "typescript" in lower or "javascript" in lower:
        return f"export function {base}() {{\n  // {description}\n}}\n"

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


def create_files(repo_path: str) -> None:
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


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate or upgrade placeholder code files")
    parser.add_argument(
        "--upgrade-placeholders",
        action="store_true",
        help="Replace existing placeholders in the generated folder using OpenAI",
    )
    args = parser.parse_args()

    repo = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

    if args.upgrade_placeholders:
        upgrade_placeholders(os.path.join(repo, "generated"))
    else:
        create_files(repo)

    fix_repo_code(repo)
    print("Auto code generation complete. Check the 'generated' folder.")
