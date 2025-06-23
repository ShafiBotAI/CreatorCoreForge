"""Load AI workflow prompt templates from Markdown."""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Dict

PROMPT_BLOCK = re.compile(r"```json\n(.*?)\n```", re.DOTALL)


def load_prompt_templates(path: str | Path) -> Dict[str, str]:
    text = Path(path).read_text(encoding="utf-8")
    match = PROMPT_BLOCK.search(text)
    if not match:
        return {}
    return json.loads(match.group(1))
