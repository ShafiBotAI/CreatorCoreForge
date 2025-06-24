"""Generate voice previews per character asynchronously."""

from __future__ import annotations

import asyncio
from typing import Callable, Awaitable

PreviewFunc = Callable[[str, str], Awaitable[str]]


class VoicePreviewer:
    def __init__(self, synthesize: PreviewFunc) -> None:
        self._synthesize = synthesize

    async def preview(self, character: str, text: str) -> str:
        """Return audio data for the given character and text."""
        return await self._synthesize(character, text)
