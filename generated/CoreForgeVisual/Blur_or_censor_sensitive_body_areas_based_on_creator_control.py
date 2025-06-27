# Auto-generated for Blur or censor sensitive body areas based on creator control
def blur_or_censor(frame: str, areas: list[str]) -> str:
    """Return a frame identifier with blur regions encoded."""
    if not areas:
        return frame
    suffix = "_".join(f"{a}-blur" for a in areas)
    return f"{frame}-{suffix}"
