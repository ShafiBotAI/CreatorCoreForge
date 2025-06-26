class WatchSyncService:
    """In-memory sync service for watch settings."""

    def __init__(self):
        self.storage = {}
        self.last_synced_progress = 0.0

    def upload(self, settings: dict, user_id: str) -> bool:
        self.storage[user_id] = settings
        return True

    def fetch(self, user_id: str):
        return self.storage.get(user_id)

    def sync(self, progress: float):
        self.last_synced_progress = max(0.0, min(1.0, progress))
