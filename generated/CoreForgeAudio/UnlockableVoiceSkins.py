class UnlockableVoiceSkins:
    """Track unlocked voice skins."""

    def __init__(self):
        self.unlocked = set()

    def unlock(self, name: str):
        self.unlocked.add(name)

    def is_unlocked(self, name: str) -> bool:
        return name in self.unlocked
