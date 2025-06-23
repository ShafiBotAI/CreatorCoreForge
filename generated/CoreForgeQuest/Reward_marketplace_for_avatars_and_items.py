"""In-memory reward marketplace for avatars and items."""
from dataclasses import dataclass
from typing import Dict, List

@dataclass
class Item:
    id: str
    name: str
    price: int

class Marketplace:
    def __init__(self) -> None:
        self._inventory: Dict[str, Item] = {}

    def add_item(self, item_id: str, name: str, price: int) -> None:
        self._inventory[item_id] = Item(item_id, name, price)

    def list_items(self) -> List[Item]:
        return list(self._inventory.values())

marketplace = Marketplace()
