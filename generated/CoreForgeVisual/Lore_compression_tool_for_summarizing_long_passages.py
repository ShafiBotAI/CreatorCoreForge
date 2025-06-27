# Auto-generated for **Lore compression tool** for summarizing long passages
def lore_compression_tool(text: str, max_len: int = 100) -> str:
    """Return a naive summary clipped to the nearest sentence boundary."""
    if len(text) <= max_len:
        return text
    end = text.rfind('.', 0, max_len)
    if end == -1:
        end = max_len
    return text[:end + 1]
