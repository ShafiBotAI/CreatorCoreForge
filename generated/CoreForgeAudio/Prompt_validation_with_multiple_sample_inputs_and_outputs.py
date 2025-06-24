"""Validate prompt templates using example inputs and outputs."""

from __future__ import annotations

from dataclasses import dataclass
from typing import List, Dict

@dataclass
class PromptExample:
    input: Dict[str, str]
    expected: str


class PromptValidator:
    """Expands templates with inputs and compares to expected outputs."""

    def __init__(self, template: str) -> None:
        self.template = template

    def validate(self, examples: List[PromptExample]) -> Dict[str, bool]:
        results: Dict[str, bool] = {}
        for example in examples:
            output = self.template.format(**example.input)
            results[str(example.input)] = output.strip() == example.expected.strip()
        return results
