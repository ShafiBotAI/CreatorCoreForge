import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.Build_Creator_dashboard_to_manage_NSFW_scene_ratings_per_book import build_creator_dashboard
from generated.CoreForgeAudio.Creator_Admin_dashboard_with_credits_usage_quota_permissions_reporting import creator_admin_dashboard
from generated.CoreForgeMarket.Cross_platform_API_integration_alerts_dashboards import cross_platform_api
from generated.CoreForgeMarket.Portfolio_and_analytics_dashboards import portfolio_and_analytics
from generated.CoreForgeVisual.Provide_creator_dashboard_to_preview_test_and_lock_character_animations import provide_creator_dashboard
from generated.CreatorCoreForge.Enable_multibook_project_dashboard_to_track_consistency import enable_multibook_project


def test_build_creator_dashboard_html():
    html = build_creator_dashboard({"scene1": 3})
    assert "scene1" in html


def test_admin_dashboard_quota():
    dash = creator_admin_dashboard()
    dash.quota = 10
    dash.add_usage(4)
    assert dash.remaining_quota() == 6


def test_cross_platform_api():
    out = cross_platform_api({"a": 1.0, "b": 2.0})
    assert out["total"] == 3.0


def test_portfolio_and_analytics():
    out = portfolio_and_analytics([1.0, 2.0, 3.0])
    assert out["value"] == 6.0


def test_animation_dashboard_lock():
    dash = provide_creator_dashboard()
    dash.preview("walk")
    dash.lock("walk")
    assert "walk" in dash.list_locked()


def test_multibook_dashboard_report():
    dash = enable_multibook_project()
    dash.add_book("book1", 10)
    assert dash.report()["chapters"] == 10
