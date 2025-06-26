class SmartAmbientMixer:
    """Mix ambient sounds in a simple stack."""

    def __init__(self):
        self.sounds = []

    def add_sound(self, name: str):
        self.sounds.append(name)

    def clear(self):
        self.sounds.clear()

    @property
    def current(self):
        return list(self.sounds)
