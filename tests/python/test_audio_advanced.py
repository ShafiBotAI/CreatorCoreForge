import pytest
from pathlib import Path
from pydub.generators import Sine
from pydub import AudioSegment
import sys

# ensure modules path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.AmbientLayerFX import ambientlayerfx
from generated.CoreForgeAudio.CrossSceneFXLinking import crossscenefxlinking
from generated.CoreForgeAudio.SceneDensityTuner import scenedensitytuner
from generated.CoreForgeAudio.EmotionCurveVisualizer import emotioncurvevisualizer
from generated.CoreForgeAudio.VoiceAwarePacing import voiceawarepacing
from generated.CoreForgeAudio.ToneConsistencyChecker import toneconsistencychecker
from generated.CoreForgeAudio.ConflictFXEnhancer import conflictfxenhancer
from generated.CoreForgeAudio.MoodColorCoder import moodcolorcoder
from generated.CoreForgeAudio.Implement_ambient_crossfade_logic_between_chapters_and_locations import (
    implement_ambient_crossfade,
)


def _tone(freq=440, dur=200):
    return Sine(freq).to_audio_segment(duration=dur)

def test_ambient_layer_fx():
    base = _tone(440, 300)
    layer = _tone(880, 300)
    out = ambientlayerfx(base, [layer], [ -3 ])
    assert len(out) == len(base)

def test_cross_scene_fx_linking():
    a = _tone(440, 200)
    b = _tone(880, 200)
    out = crossscenefxlinking(a, b, crossfade_ms=50)
    assert len(out) == len(a) + len(b) - 50

def test_implement_ambient_crossfade():
    a = _tone(440, 200)
    b = _tone(660, 200)
    out = implement_ambient_crossfade(a, b, crossfade_ms=75)
    assert len(out) == len(a) + len(b) - 75

def test_scene_density_tuner():
    tone = _tone()
    denser = scenedensitytuner(tone, 1.5)
    assert len(denser) == len(tone)


def test_emotion_curve_visualizer():
    fig = emotioncurvevisualizer([0, 1, 0.5])
    assert hasattr(fig, "savefig")


def test_voice_aware_pacing():
    tone = _tone(440, 300)
    faster = voiceawarepacing(tone, 1.2)
    assert len(faster) < len(tone)


def test_tone_consistency_checker():
    segs = [_tone(440, 100), _tone(441, 100)]
    assert toneconsistencychecker(segs)


def test_conflict_fx_enhancer():
    tone = _tone(440, 200)
    out = conflictfxenhancer(tone, 0.5)
    assert len(out) == len(tone)


def test_mood_color_coder():
    assert moodcolorcoder("tense") == "#ff0000"
