class VoicePolls:
    """Simple poll tracker for voices."""

    def __init__(self):
        self.votes = {}

    def vote(self, option: str):
        self.votes[option] = self.votes.get(option, 0) + 1

    def top_choice(self):
        if not self.votes:
            return None
        return max(self.votes.items(), key=lambda x: x[1])[0]
