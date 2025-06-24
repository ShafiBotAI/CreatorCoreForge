# Auto-generated for Enable "live panel" layout for comic/manga-style visual composition
from typing import List


def enable_live_panel(panels: List[str]) -> List[str]:
    """Return a sequence of panel captions for layout previews."""

    return [f"Panel {i+1}: {caption}" for i, caption in enumerate(panels)]
