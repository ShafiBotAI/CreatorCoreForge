# Auto-generated for Provide customizable NSFW cover and thumbnail censor options
def provide_customizable_nsfw(cover: str, level: int = 1) -> str:
    """Return a censored cover string based on level."""

    if level <= 0:
        return cover
    return f"{cover}-censored{level}"
