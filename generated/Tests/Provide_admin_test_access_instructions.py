# Auto-generated for Provide admin test access instructions
import os


def provide_admin_test() -> str:
    """Return basic instructions for running the test suite as an admin."""

    ci_hint = (
        "Run 'scripts/run_all_tests.sh' to execute the full test suite. "
        "Ensure you have write permissions in the repository and the "
        "CI environment variables set (e.g. CI=1, GITHUB_ACTIONS=1)."
    )
    if os.getenv("CI"):
        return ci_hint + " CI environment detected."
    return ci_hint
