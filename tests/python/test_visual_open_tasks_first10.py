import os
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[2]))
from generated.CoreForgeVisual.End_to_end_cinematic_video_creation_from_text_book_script_input import end_to_end
from generated.CoreForgeVisual.Persistent_character_scene_memory_across_books_and_series import (
    persistent_character_scene,
    memory_snapshot,
)
from generated.CoreForgeVisual.Support_for_iOS_Android_PC_macOS_and_Web import support_for_ios
from generated.CoreForgeVisual.Multilingual_NSFW_gating_offline_content_marketplace_AR_VR_social_viral_and_creator_features import multilingual_nsfw_gating
from generated.CoreForgeVisual.AI_character_detection_and_persistent_visual_voice_memory import (
    ai_character_detection,
    update_character_voice,
    update_character_visual,
    character_memory,
)
from generated.CoreForgeVisual.Scene_by_scene_video_dramatization_export_download import scene_by_scene
from generated.CoreForgeVisual.Multi_style_rendering_anime_live_fantasy_etc import multi_style_rendering
from generated.CoreForgeVisual.Adaptive_soundtrack_and_voice_SFX_per_scene import adaptive_soundtrack_and
from generated.CoreForgeVisual.Drag_and_drop_scene_shot_and_effect_editor import drag_and_drop
from generated.CoreForgeVisual.In_app_streaming_and_offline_playback import in_app_streaming


def test_end_to_end():
    files = end_to_end("A\n\nB")
    assert files == ["scene_0.mp4", "scene_1.mp4"]


def test_persistent_character_scene():
    persistent_character_scene("Book", "S1")
    persistent_character_scene("Book", "S2")
    assert memory_snapshot()["Book"] == ["S1", "S2"]


def test_support_for_ios():
    assert "iOS" in support_for_ios()


def test_multilingual_nsfw_gating():
    cfg = multilingual_nsfw_gating()
    assert cfg["nsfw_gating"] and cfg["multilingual"]


def test_ai_character_detection_memory():
    names = ai_character_detection("Alice meets Bob")
    update_character_voice("Alice", "soft")
    update_character_visual("Alice", "tall")
    mem = character_memory()
    assert "Alice" in names and mem["Alice"]["voice"] == "soft"


def test_scene_by_scene():
    files = scene_by_scene(["s1", "s2"])
    assert files[1] == "scene_1.mp4"


def test_multi_style_rendering():
    out = multi_style_rendering("anime", ["f"]) 
    assert out == ["anime:f"]


def test_adaptive_soundtrack_and():
    assert adaptive_soundtrack_and("horror").endswith(".mp3")


def test_drag_and_drop():
    assert drag_and_drop(["shot1", "fx"]) == ["drop:shot1", "drop:fx"]


def test_in_app_streaming(tmp_path):
    data = b"123"
    file_path = in_app_streaming(data, offline=True)
    assert os.path.exists(file_path)
    os.remove(file_path)
    stream = in_app_streaming(data)
    assert stream.startswith("streaming_")
