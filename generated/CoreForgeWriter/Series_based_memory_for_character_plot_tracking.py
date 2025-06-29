# Auto-generated for Series-based memory for character/plot tracking
def series_based_memory(memory_db=None, character=None, plot_point=None):
    """Simple series-based memory tracker.

    Parameters
    ----------
    memory_db : dict, optional
        Existing memory database mapping characters to plot notes.
    character : str, optional
        Character name to update.
    plot_point : str, optional
        Plot point or summary to append for the character.

    Returns
    -------
    dict
        Updated memory database.
    """
    if memory_db is None:
        memory_db = {}

    if character and plot_point:
        memory_db.setdefault(character, []).append(plot_point)

    return memory_db
