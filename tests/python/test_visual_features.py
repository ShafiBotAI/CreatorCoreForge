import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeVisual.Enable_cutaway_logic_for_interior_vs_exterior_visual_blending import enable_cutaway_logic
from generated.CoreForgeVisual.Simulate_mood_via_hue_shifting_and_saturation_overlays import simulate_mood_via
from generated.CoreForgeVisual.Support_dynamic_shadows_and_ambient_occlusion_for_realism import support_dynamic_shadows
from generated.CoreForgeVisual.Trigger_visual_filters_noir_dream_sepia_neon_based_on_scene_metadata import trigger_visual_filters
from generated.CoreForgeVisual.Identify_high_impact_moments_and_render_with_frame_by_frame_detail import identify_high_impact
from generated.CoreForgeVisual.Support_16_9_vertical_and_square_rendering_formats import support_vertical_and
from generated.CoreForgeVisual.Enable_live_panel_layout_for_comic_manga_style_visual_composition import enable_live_panel
from generated.CoreForgeVisual.Add_blur_shake_or_light_flash_FX_for_dramatic_or_horror_moments import add_blur_shake
from generated.CoreForgeVisual.Sync_scene_tone_to_ambient_background_FX_audio import sync_scene_tone
from generated.CoreForgeVisual.Store_FX_template_libraries_per_genre_for_reuse import store_fx_template, get_fx_templates
from generated.CoreForgeVisual.Allow_creator_to_preview_FX_before_rendering_full_scenes import allow_creator_to
from generated.CoreForgeVisual.Provide_toggle_between_high_quality_and_quick_preview_render_settings import provide_toggle_between
from generated.CoreForgeVisual.Visualize_FX_layering_structure_for_post_editing import visualize_fx_layering
from generated.CoreForgeVisual.Integrate_facial_motion_tracking_for_emotional_match_rendering import integrate_facial_motion
from generated.CoreForgeVisual.Track_render_time_estimates_and_optimize_batch_processing_queue import track_render_time
from generated.CoreForgeVisual.Tag_visual_rhythm_speed_slow_visual_poetry_vs_fast_action_montage import tag_visual_rhythm
from generated.CoreForgeVisual.Persist_character_visuals_across_multiple_books_including_costume_and_evolution import (
    persist_character_visuals, get_character_visuals
)
from generated.CoreForgeVisual.Maintain_memory_of_key_visual_motifs_and_use_them_in_flashbacks_or_callouts import (
    maintain_memory_of, recall_motifs
)
from generated.CoreForgeVisual.Store_visual_timeline_of_each_character_s_age_look_and_setting_impact import (
    store_visual_timeline, get_visual_timeline
)
from generated.CoreForgeVisual.Flag_continuity_errors_in_casting_color_palette_or_background_reuse import flag_continuity_errors


def test_cutaway_logic():
    result = enable_cutaway_logic("int", "ext", 0.3)
    assert result["ratio"] == 0.3


def test_simulate_mood():
    h, s = simulate_mood_via(0.0, 0.5, 0.2)
    assert 0.19 < h < 0.21
    assert s > 0.5


def test_dynamic_shadows():
    vals = support_dynamic_shadows([0.0, 1.0], 0.5)
    assert len(vals) == 2


def test_trigger_filters():
    assert trigger_visual_filters(["dream sequence"]) == "dream"
    assert trigger_visual_filters([]) == "none"


def test_high_impact():
    idx = identify_high_impact([0.2, 0.9, 0.5], 0.8)
    assert idx == [1]


def test_aspect_ratio():
    w, h = support_vertical_and(1920, 1080)
    assert (w, h) == (1920, 1080)


def test_live_panel():
    out = enable_live_panel(["A", "B"])
    assert out[0].startswith("Panel 1")


def test_blur_shake():
    assert add_blur_shake(0.8) == "light_flash"


def test_sync_tone():
    assert sync_scene_tone("sad") == "rain"


def test_fx_template():
    store_fx_template("horror", ["fog"])
    assert "fog" in get_fx_templates("horror")


def test_fx_preview():
    assert "Preview blur" in allow_creator_to("blur", 1.0)


def test_toggle_quality():
    assert provide_toggle_between("high") == 60


def test_visualize_fx_layering():
    diag = visualize_fx_layering(["bg", "fx1"])
    assert ">" in diag


def test_facial_motion():
    count = integrate_facial_motion([(0, 0), (1, 2)])
    assert count == 2


def test_track_render_time():
    avg = track_render_time([1.0, 2.0, 3.0])
    assert avg == 2.0


def test_tag_visual_rhythm():
    assert tag_visual_rhythm(24) == "slow"


def test_character_visuals():
    persist_character_visuals("hero", {"costume": "cape"})
    assert get_character_visuals("hero")["costume"] == "cape"


def test_motif_memory():
    maintain_memory_of("book1", ["red"])
    assert "red" in recall_motifs("book1")


def test_visual_timeline():
    store_visual_timeline("hero", "scene1")
    assert get_visual_timeline("hero") == ["scene1"]


def test_continuity_errors():
    errs = flag_continuity_errors([("a", "bg1"), ("b", "bg1"), ("c", "bg2")])
    assert errs == [1]
