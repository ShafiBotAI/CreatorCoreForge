class ReplayAnalytics:
    class Stats:
        def __init__(self):
            self.replays = 0
            self.skips = 0
            self.loops = 0

    def __init__(self):
        self.log = {}

    def record_replay(self, line: str):
        stats = self.log.setdefault(line, self.Stats())
        stats.replays += 1

    def record_skip(self, line: str):
        stats = self.log.setdefault(line, self.Stats())
        stats.skips += 1

    def record_loop(self, line: str):
        stats = self.log.setdefault(line, self.Stats())
        stats.loops += 1

    def stats(self, line: str):
        return self.log.get(line, self.Stats())

    def reset(self):
        self.log.clear()


class ReplayAnalyticsService:
    """Python port of the Swift ReplayAnalyticsService"""
    def __init__(self):
        self.analytics = ReplayAnalytics()

    def record_replay(self, line: str):
        self.analytics.record_replay(line)

    def stats(self, line: str):
        return self.analytics.stats(line)

    def reset(self):
        self.analytics.reset()
