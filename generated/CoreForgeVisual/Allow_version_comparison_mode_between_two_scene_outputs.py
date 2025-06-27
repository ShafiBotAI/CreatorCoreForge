# Auto-generated for Allow version comparison mode between two scene outputs
def allow_version_comparison(scene_a: str, scene_b: str) -> dict:
    """Return a diff-like summary of two scene versions."""
    return {
        "a": scene_a,
        "b": scene_b,
        "changed": scene_a != scene_b,
    }
