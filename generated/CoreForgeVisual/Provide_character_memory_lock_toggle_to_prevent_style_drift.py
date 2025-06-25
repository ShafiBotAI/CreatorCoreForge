# Auto-generated for Provide character memory "lock" toggle to prevent style drift
class CharacterMemory:
    """Represents a character's memory with an optional lock."""

    def __init__(self) -> None:
        self.locked = False
        self.data = {}

    def toggle_lock(self) -> None:
        self.locked = not self.locked

    def update(self, key: str, value: str) -> None:
        if not self.locked:
            self.data[key] = value


def provide_character_memory() -> CharacterMemory:
    """Return a new :class:`CharacterMemory` instance."""

    return CharacterMemory()
