# Auto-generated for **Adaptive AI memory** to maintain story and character continuity
class AdaptiveAIMemory:
    """Minimal adaptive memory manager."""

    def __init__(self):
        self.entries = []

    def remember(self, text: str):
        self.entries.append(text)

    def recall_last(self, n: int = 1):
        return self.entries[-n:]
