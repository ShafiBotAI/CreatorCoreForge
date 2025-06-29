# Auto-generated for Multi-book support (up to 1000 pages) (Codex)
def multi_book_support(books):
    """Merge multiple books into a single list of pages."""
    merged = []
    for book in books:
        merged.extend(book[:1000])
    return merged
