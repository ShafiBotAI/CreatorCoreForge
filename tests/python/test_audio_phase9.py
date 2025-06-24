import os
from pathlib import Path
from pydub.generators import Sine
from pydub import AudioSegment
import sys

# ensure modules path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.Offer_toggle_for_narrator_override_mode_for_consistency_across_multi_voice_scenes import offer_toggle_for
from generated.CoreForgeAudio.Auto_suggest_optimal_scene_pacing_based_on_text_intensity_and_emotion_tags import auto_suggest_optimal
from generated.CoreForgeAudio.Detect_dialogue_overlap_potential_and_adjust_timing_automatically import detect_dialogue_overlap
from generated.CoreForgeAudio.Use_AI_to_recommend_narration_cadence_per_genre_and_reader_preference import use_ai_to
from generated.CoreForgeAudio.Export_final_audio_as_flattened_or_layered_file_based_on_creator_choice import export_final_audio
from generated.CoreForgeAudio.Tag_character_emotional_states_per_segment_to_match_musical_score_inputs import tag_character_emotional
from generated.CoreForgeAudio.Link_scene_based_voice_dynamics_to_background_music_templates import link_scene_based
from generated.CoreForgeAudio.Integrate_with_audio_plugin_systems_for_advanced_mastering_tools import register_plugin, integrate_with_audio
from generated.CoreForgeAudio.Enable_Creator_AI_Assistant_to_generate_scene_specific_mastering_presets import enable_creator_ai
from generated.CoreForgeAudio.Provide_auto_mix_and_export_mode_for_rapid_prototyping import provide_auto_mix
from generated.CoreForgeAudio.Build_creator_dashboard_for_real_time_monitoring_of_voice_quality_and_performance import build_creator_dashboard
from generated.CoreForgeAudio.Visualize_voice_dominance_per_chapter_using_waveform_or_tone_charts import visualize_voice_dominance
from generated.CoreForgeAudio.Offer_beta_features_audio_fingerprints_for_licensing_alternate_casting_previews import offer_beta_features
from generated.CoreForgeAudio.AI_based_performance_coach_to_recommend_enhancements_after_preview import ai_based_performance


def _tone(freq=440, dur=200):
    return Sine(freq).to_audio_segment(duration=dur)


def test_offer_toggle_for():
    out = offer_toggle_for({}, True)
    assert out["narrator_override"] is True


def test_auto_suggest_optimal():
    label = auto_suggest_optimal("hello world", [0.1, 0.2])
    assert isinstance(label, str)


def test_detect_dialogue_overlap():
    segs = detect_dialogue_overlap([(0, 1000), (500, 1200)])
    assert segs[1][0] >= segs[0][1]


def test_use_ai_to():
    rate = use_ai_to("thriller")
    assert rate > 1.0


def test_export_final_audio(tmp_path: Path):
    tracks = {
        "a": _tone(440, 100),
        "b": _tone(880, 100),
    }
    out = export_final_audio(tracks, str(tmp_path / "mix.wav"))
    assert Path(out).is_file()
    layered_dir = export_final_audio(tracks, str(tmp_path / "layered"), layered=True)
    assert Path(layered_dir).is_dir()


def test_tag_character_emotional():
    pairs = tag_character_emotional(["hi"], ["happy"])
    assert pairs == [("hi", "happy")]


def test_link_scene_based():
    mapping = link_scene_based(["calm", "tense"], ["a"])
    assert mapping["tense"] == "a"


def test_integrate_with_audio():
    register_plugin("test", lambda b: b"x" + b)
    assert integrate_with_audio("test", b"a") == b"xa"


def test_enable_creator_ai():
    preset = enable_creator_ai("action scene")
    assert "compress" in preset


def test_provide_auto_mix(tmp_path: Path):
    tracks = {"a": _tone(440, 50), "b": _tone(880, 50)}
    out = provide_auto_mix(tracks, str(tmp_path / "auto.wav"))
    assert Path(out).is_file()


def test_build_creator_dashboard():
    html = build_creator_dashboard({"quality": 1.0})
    assert "<table>" in html


def test_visualize_voice_dominance():
    stats = visualize_voice_dominance({"a": 2, "b": 2})
    assert stats["a"] == 50.0


def test_offer_beta_features(tmp_path: Path):
    p = tmp_path / "t.wav"
    _tone().export(p, format="wav")
    fp = offer_beta_features(str(p))
    assert len(fp) == 64


def test_ai_based_performance():
    suggestions = ai_based_performance({"pitch_variance": 0.05})
    assert suggestions
