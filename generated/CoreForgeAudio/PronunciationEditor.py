class PronunciationEditor:
    """Stores custom phoneme mappings."""

    def __init__(self):
        self.custom = {}

    def set_phonemes(self, phonemes, word):
        self.custom[word.lower()] = phonemes

    def remove_word(self, word):
        self.custom.pop(word.lower(), None)

    def phonemes(self, word):
        return self.custom.get(word.lower(), list(word))
