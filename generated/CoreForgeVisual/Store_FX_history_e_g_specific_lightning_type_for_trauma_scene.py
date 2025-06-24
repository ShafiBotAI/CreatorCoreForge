# Auto-generated for Store FX history (e.g., specific lightning type for trauma scene)
from typing import List, Dict


def store_fx_history(history: List[Dict], fx: Dict) -> List[Dict]:
    """Append ``fx`` to the ``history`` list and return it."""

    history = list(history)
    history.append(fx)
    return history
