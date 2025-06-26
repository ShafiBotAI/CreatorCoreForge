import random

class AutoRemixMode:
    """Shuffle a list of chapter indexes."""

    def remix(self, chapters):
        chapters = list(chapters)
        random.shuffle(chapters)
        return chapters
