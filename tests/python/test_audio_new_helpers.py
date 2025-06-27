import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.AI_coach_for_pronunciation_pacing_performance_feedback import analyze_speech
from generated.CoreForgeAudio.Add_cross_device_sync_track_last_listened_chapter_scene_and_timestamp import update_position, load_position
from generated.CoreForgeAudio.Add_DRM_toggle_for_exports_requiring_usage_protection import apply_drm


def test_analyze_speech_basic():
    transcript = "hello world " * 50  # 100 words
    result = analyze_speech(transcript, 50)  # 50 seconds -> 120 WPM
    assert 119 <= result["wpm"] <= 121
    assert result["avg_word_length"] > 0


def test_cross_device_sync(tmp_path):
    sync_file = tmp_path / "sync.json"
    update_position("book1", 1, 2, 33.5, sync_file)
    pos = load_position("book1", sync_file)
    assert pos == {"chapter": 1, "scene": 2, "timestamp": 33.5}


def test_apply_drm():
    meta = {"title": "Test"}
    out = apply_drm(meta, True)
    assert out["drm_protected"] == "true"
    out = apply_drm(meta, False)
    assert out["drm_protected"] == "false"
