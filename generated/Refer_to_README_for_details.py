# Auto-generated for Refer to README for details.
import os


def refer_to_readme() -> str:
    """Return the contents of the project's ``README.md`` file."""
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    readme_path = os.path.join(repo_root, "README.md")
    with open(readme_path, "r", encoding="utf-8") as fh:
        return fh.read()


__all__ = ["refer_to_readme"]
