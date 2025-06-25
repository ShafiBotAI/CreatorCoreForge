"""DynamicBuildToolkit004 – manage simple build tasks."""


def apply_toolchain(toolchain: list[str]) -> list[str]:
    """Return list of tasks applied in order."""
    return [f"apply:{t}" for t in toolchain]
