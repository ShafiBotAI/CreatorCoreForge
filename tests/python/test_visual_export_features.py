import sys
from pathlib import Path
import pytest
sys.path.append(str(Path(__file__).resolve().parents[2]))

from collections import deque

from generated.CoreForgeVisual.Include_thumbnail_and_cover_art_generation_from_key_frames import include_thumbnail_and
from generated.CoreForgeVisual.Auto_generate_subtitle_tracks_synced_with_voice_and_visuals import auto_generate_subtitle
from generated.CoreForgeVisual.Embed_chapter_metadata_and_timeline_jump_points_for_playback_platforms import embed_chapter_metadata
from generated.CoreForgeVisual.Export_to_YouTube_TikTok_and_Instagram_Reels_via_platform_integrations import export_to_youtube
from generated.CoreForgeVisual.Sync_export_state_with_cloud_and_local_storage import sync_export_state
from generated.CoreForgeVisual.Track_export_history_by_book_scene_and_version import track_export_history, get_export_history
from generated.CoreForgeVisual.Bundle_FX_character_and_voice_layers_for_full_scene_archives import bundle_fx_character
from generated.CoreForgeVisual.Offer_watermarking_and_brand_tagging_options import offer_watermarking_and
from generated.CoreForgeVisual.Enable_multi_resolution_export_for_preview_vs_final_render import enable_multi_resolution
from generated.CoreForgeVisual.Gate_export_privileges_by_subscription_tier_e_g_4K_Creator_only import gate_export_privileges
from generated.CoreForgeVisual.Support_batch_export_queue_with_export_profile_presets import support_batch_export
from generated.CoreForgeVisual.Auto_optimize_exports_for_bandwidth_constrained_environments import auto_optimize_exports
from generated.CoreForgeVisual.Enable_NSFW_safe_export_modes_blur_replace_censor_layers import enable_nsfw_safe
from generated.CoreForgeVisual.Support_creator_stamped_end_credits_or_intro_overlays import support_creator_stamped
from generated.CoreForgeVisual.Track_subscription_credits_and_export_quota_by_user import track_subscription_credits
from generated.CoreForgeVisual.Allow_in_app_purchases_for_one_time_HD_or_commercial_use_licenses import allow_in_app
from generated.CoreForgeVisual.Provide_DRM_encoding_option_for_IP_protected_outputs import provide_drm_encoding
from generated.CoreForgeVisual.Sync_exported_files_across_devices_with_user_authentication import sync_exported_files
from generated.CoreForgeVisual.Offer_creator_branded_export_template_themes_logos_font_outro import offer_creator_branded
from generated.CoreForgeVisual.Generate_trailer_versions_from_book_to_video_projects_automatically import generate_trailer_versions
from generated.CoreForgeVisual.UnifiedVideoEngine import unified_video_engine


def test_thumbnails():
    thumbs = include_thumbnail_and(["frame1", "frame2"])
    assert thumbs == ["frame1_thumb.jpg", "frame2_thumb.jpg"]


def test_subtitles():
    subs = auto_generate_subtitle(["hi", "bye"], [1.0, 2.0])
    assert subs[1][0] == 1.0 and subs[1][1] == 3.0


def test_embed_chapter_metadata():
    data = embed_chapter_metadata({"book": "a"}, [0, 10])
    assert data["jumps"] == [0, 10]


def test_export_platforms():
    msgs = export_to_youtube("video.mp4", ["YouTube"])
    assert "YouTube" in msgs[0]


def test_sync_export_state():
    result = sync_export_state({"s": "1"}, {})
    assert result["s"] == "1"


def test_export_history():
    track_export_history("book", "scene", "v1")
    assert get_export_history("book", "scene")[0][0] == "v1"


def test_bundle_fx():
    out = bundle_fx_character({"fx": "rain"})
    assert "fx" in out


def test_watermark():
    out = offer_watermarking_and("vid", "wm")
    assert out.endswith("wm")


def test_multi_res():
    res = enable_multi_resolution(["720p", "1080p", "720p"])
    assert res == ["1080p", "720p"] or res == ["720p", "1080p"]


def test_gate_export():
    assert gate_export_privileges("creator", "4K")
    assert not gate_export_privileges("free", "4K")


def test_batch_queue():
    q = deque([1, 2, 3])
    assert support_batch_export(q) == 3 and len(q) == 0


def test_auto_optimize():
    assert auto_optimize_exports(100.0) == 50.0


def test_nsfw_safe():
    assert enable_nsfw_safe(2) == "replace"


def test_creator_stamped():
    assert support_creator_stamped("vid", "bob") == "vid_by_bob.mp4"


def test_subscription_credits():
    remaining = track_subscription_credits("alice", 2)
    assert remaining == 8


def test_in_app():
    assert allow_in_app(10.0, 5.0) == 5.0


def test_drm():
    assert provide_drm_encoding("123") == "DRM-123"


def test_sync_files():
    devices = {"phone": []}
    res = sync_exported_files(["f.mp4"], devices)
    assert "f.mp4" in res["phone"]


def test_creator_branded():
    assert "logo" in offer_creator_branded({"logo": "L"})


def test_trailer():
    assert generate_trailer_versions(100.0, 0.2) == 20.0


def test_unified_video_engine_missing_dep(tmp_path):
    with pytest.raises(RuntimeError):
        unified_video_engine([str(tmp_path / "a.mp4")], str(tmp_path / "out.mp4"))

