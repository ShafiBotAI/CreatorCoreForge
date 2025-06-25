# Auto-generated for Enable NSFW-safe export modes (blur, replace, censor layers)
def enable_nsfw_safe(level: int) -> str:
    """Return a description of the applied NSFW safe mode."""

    if level <= 0:
        return "none"
    elif level == 1:
        return "blur"
    elif level == 2:
        return "replace"
    else:
        return "censor"
