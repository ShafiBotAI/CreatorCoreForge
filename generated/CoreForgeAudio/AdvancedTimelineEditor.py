class AdvancedTimelineEditor:
    """Manage timeline markers."""

    def __init__(self):
        self.markers = {}

    def insert(self, marker: str, time: float):
        self.markers[time] = marker

    def remove_marker(self, time: float):
        return self.markers.pop(time, None)

    def marker(self, time: float):
        return self.markers.get(time)

    def all_markers(self):
        return sorted(self.markers.items())
