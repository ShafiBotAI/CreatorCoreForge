from typing import List, Dict

def generate_initial_visual(scenes: List[str]) -> List[Dict[str, int | str]]:
    """Generate a simple storyboard layout from scenes."""
    return [{"index": i, "text": scene.strip()} for i, scene in enumerate(scenes)]
