from pydub.generators import Sine
from pydub import AudioSegment
from pathlib import Path
import sys

# Ensure the generated modules are discoverable
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.CadenceModulation import cadencemodulation
from generated.CoreForgeAudio.InterruptSimulation import interruptsimulation
from generated.CoreForgeAudio.StutterLaughGenerator import stutterlaughgenerator
from generated.CoreForgeAudio.InlineWhisperSupport import inlinewhispersupport
from generated.CoreForgeAudio.MidSentenceToneSwitching import midsentencetoneswitching
from generated.CoreForgeAudio.SceneVolumeDynamics import scenevolumedynamics
from generated.CoreForgeAudio.SpatialPositioning import spatialpositioning
from generated.CoreForgeAudio.RoomSimulation import roomsimulation
from generated.CoreForgeAudio.ScriptSnippetInjector import scriptsnippetinjector
from generated.CoreForgeAudio.CreatorSandboxMode import creatorsandboxmode
from generated.CoreForgeAudio.DualNarratorToggle import dualnarratortoggle
from generated.CoreForgeAudio.VoiceDNAForking import voicednaforking
from generated.CoreForgeAudio.FlashbackSceneEngine import flashbacksceneengine
from generated.CoreForgeAudio.VoicePersonalityProfiles import VoiceProfile


def _tone(duration=200):
    return Sine(440).to_audio_segment(duration=duration)


def test_cadence_modulation():
    tone = _tone(500)
    faster = cadencemodulation(tone, 1.5)
    assert len(faster) < len(tone)


def test_interrupt_simulation():
    tone = _tone(500)
    out = interruptsimulation(tone, [250], silence_ms=100)
    assert len(out) == len(tone) + 100


def test_stutter_laugh_generator():
    tone = _tone(200)
    out = stutterlaughgenerator(tone, syllable_ms=50, repetitions=2)
    assert len(out) == len(tone) + 100


def test_inline_whisper_support():
    tone = _tone(500)
    out = inlinewhispersupport(tone, 100, 200)
    assert len(out) == len(tone)


def test_mid_sentence_tone_switching():
    tone = _tone(400)
    out = midsentencetoneswitching(tone, 200, 1.2)
    assert len(out) <= len(tone)


def test_scene_volume_dynamics():
    tone = _tone(300)
    out = scenevolumedynamics(tone, fade_in_ms=50, fade_out_ms=50)
    assert len(out) == len(tone)


def test_spatial_positioning():
    tone = _tone(300).set_channels(2)
    out = spatialpositioning(tone, -0.5)
    assert out.channels == 2


def test_room_simulation():
    tone = _tone(300)
    out = roomsimulation(tone, delay_ms=50, decay=0.5, repeats=1)
    assert len(out) >= len(tone)


def test_script_snippet_injector():
    script = "a\nb"
    out = scriptsnippetinjector(script, "X", 1)
    assert out.splitlines()[1] == "X"


def test_creator_sandbox_mode(tmp_path: Path):
    with creatorsandboxmode() as path:
        p = path / "test.txt"
        p.write_text("hi")
        assert p.is_file()
    assert not p.exists()


def test_dual_narrator_toggle():
    primary = _tone(200)
    secondary = _tone(200)
    out = dualnarratortoggle(primary, secondary, enabled=True)
    assert len(out) == len(primary)


def test_voice_dna_forking():
    base = VoiceProfile(name="hero")
    fork = voicednaforking(base, pitch=1.1)
    assert fork.name != base.name
    assert fork.pitch == 1.1


def test_flashback_scene_engine():
    tone = _tone(200)
    out = flashbacksceneengine(tone)
    assert len(out) >= len(tone)
