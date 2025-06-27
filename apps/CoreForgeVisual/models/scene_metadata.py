from dataclasses import dataclass, asdict
from typing import List, Optional
import json

@dataclass
class SceneMetadata:
    scene_id: int
    description: str
    tags: Optional[List[str]] = None

    def to_json(self) -> str:
        return json.dumps(asdict(self))

    @staticmethod
    def from_json(data: str) -> "SceneMetadata":
        payload = json.loads(data)
        return SceneMetadata(**payload)
