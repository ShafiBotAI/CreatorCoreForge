# Auto-generated for Add NSFW mode toggle with age-gated access and verification

class NSFWMode:
    def __init__(self):
        self.enabled = False

    def toggle(self, age_verified: bool):
        if age_verified:
            self.enabled = not self.enabled
        return self.enabled
