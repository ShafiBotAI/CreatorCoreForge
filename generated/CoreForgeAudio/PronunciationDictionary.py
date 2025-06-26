class PronunciationDictionary:
    """Store custom pronunciations."""

    def __init__(self):
        self.entries = {}

    def add(self, word: str, phonemes: str):
        self.entries[word] = phonemes

    def phonemes(self, word: str):
        return self.entries.get(word)
