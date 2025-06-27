# Auto-generated for Output visual scene map to timeline panel for creator editing
def output_visual_scene(scenes: list[str]) -> list[dict]:
    """Return scene map entries with timeline indices."""
    return [{"index": i, "scene": s} for i, s in enumerate(scenes)]
