# Auto-generated for Allow creator-defined "main" timeline and secondary forks

class TimelineManager:
    def __init__(self):
        self.timelines = {"main": []}

    def add_scene(self, tag: str, scene):
        self.timelines.setdefault(tag, []).append(scene)

    def get_timeline(self, tag: str):
        return self.timelines.get(tag, [])
