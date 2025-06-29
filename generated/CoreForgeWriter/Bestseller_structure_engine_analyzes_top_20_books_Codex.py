# Auto-generated for Bestseller structure engine (analyzes top 20 books) (Codex)
def bestseller_structure_engine(bestsellers):
    """Return common structural patterns from bestsellers.

    Parameters
    ----------
    bestsellers : list[str]
        Collection of text representing top-selling books.

    Returns
    -------
    dict
        Mapping of pattern to frequency.
    """
    patterns = {}
    for book in bestsellers:
        for word in book.split():
            patterns[word] = patterns.get(word, 0) + 1

    return patterns
