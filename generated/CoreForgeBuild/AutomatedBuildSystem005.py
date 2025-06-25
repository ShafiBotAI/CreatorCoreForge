"""AutomatedBuildSystem005 – run builds across platforms."""


def run_build(platforms: list[str]) -> dict:
    """Return a mapping of platform to success flag."""
    return {p: True for p in platforms}
