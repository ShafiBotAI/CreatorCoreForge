import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.ContinuityChecker import continuitychecker
from generated.CoreForgeAudio.CrossoverEngine import crossoverengine


def test_continuity_checker():
    scenes = [
        {"location": "A", "characters": ["x", "y"]},
        {"location": "B", "characters": ["x"]},
        {"location": "B", "characters": ["x", "y"]},
    ]
    notes = continuitychecker(scenes)
    assert any("location changed" in n for n in notes)
    assert any("characters missing" in n for n in notes)


def test_crossover_engine():
    a = [{"name": "hero"}, {"name": "villain"}]
    b = [{"name": "hero"}, {"name": "sidekick"}]
    mapping = crossoverengine(a, b)
    assert mapping["hero"] == ["both"]
    assert mapping["villain"] == ["A"]
    assert mapping["sidekick"] == ["B"]
