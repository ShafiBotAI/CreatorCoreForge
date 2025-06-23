import os
import re
from typing import List

try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False

from feature_audit import scan_repo


def offline_snippet(description: str) -> str:
    """Return a very small placeholder snippet."""
    tokens = re.findall(r"[a-zA-Z_]+", description)[:5]
    name = sanitize("_".join(tokens).lower()) or "feature"
    return f"def {name}():\n    \"\"\"{description}\"\"\"\n    pass\n"


def sanitize(name: str) -> str:
    """Return a filesystem-safe name."""
    return re.sub(r"[^a-zA-Z0-9_]+", "_", name.strip()).strip("_") or "feature"


def generate_snippet(description: str) -> str:
    """Generate a code snippet using OpenAI or fallback offline mode."""
    if OPENAI_AVAILABLE and os.getenv("OPENAI_API_KEY"):
        api_key = os.getenv("OPENAI_API_KEY")
        openai.api_key = api_key
        prompt = (
            "Write a concise code snippet or function to address the following feature:\n"
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
            return offline_snippet(description)
    else:
        return offline_snippet(description)


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
            fname = sanitize(feature) + ".txt"
            fpath = os.path.join(app_dir, fname)
            if os.path.exists(fpath):
                continue
            snippet = generate_snippet(feature)
            with open(fpath, "w", encoding="utf-8") as f:
                f.write(f"# Auto-generated for {feature}\n")
                f.write(snippet)


if __name__ == "__main__":
    repo = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    create_files(repo)
    print("Auto code generation complete. Check the 'generated' folder.")
