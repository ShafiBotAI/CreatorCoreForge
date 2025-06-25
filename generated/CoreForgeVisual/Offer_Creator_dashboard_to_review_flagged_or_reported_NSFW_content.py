# Auto-generated for Offer Creator dashboard to review flagged or reported NSFW content
class CreatorDashboard:
    """Simple tracker for flagged NSFW content."""

    def __init__(self) -> None:
        self.flagged = []

    def report(self, scene_id: str) -> None:
        self.flagged.append(scene_id)

    def list_reports(self) -> list:
        return list(self.flagged)


def offer_creator_dashboard() -> CreatorDashboard:
    """Return a dashboard instance for managing NSFW reports."""

    return CreatorDashboard()
