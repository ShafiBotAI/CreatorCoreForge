# Auto-generated for Provide toggle between high-quality and quick-preview render settings
def provide_toggle_between(mode: str) -> int:
    """Return a sample frame rate based on the mode."""

    return 60 if mode == "high" else 24
