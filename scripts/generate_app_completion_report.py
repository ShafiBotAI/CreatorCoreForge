import json
from calc_app_completion import scan_apps
import sys


def _progress_bar(percent: float, length: int = 10) -> str:
    """Return a textual progress bar for the given percentage."""
    filled = int(round(percent / 100 * length))
    return "█" * filled + "░" * (length - filled)

if __name__ == '__main__':
    apps_dir = sys.argv[1] if len(sys.argv) > 1 else 'apps'
    results = scan_apps(apps_dir)
    report = {}
    for app, data in results.items():
        percent = (data['done'] / data['total']) * 100 if data['total'] else 0
        report[app] = {
            'done': data['done'],
            'total': data['total'],
            'percent_complete': round(percent, 1)
        }
    with open('app_completion_report.json', 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2)
    print('Wrote app_completion_report.json')

    # Generate Markdown summary with progress bars
    sorted_apps = sorted(report.items(), key=lambda x: x[0])
    lines = [
        "# App Completion Summary",
        "",
        "This document lists each app and its completion percentage based on task checklists in `apps/*/AGENTS.md`.\n",
        "| App | Completion | Progress |",
        "|-----|------------|----------|",
    ]
    high_completion = []
    for app, data in sorted_apps:
        pct = data["percent_complete"]
        bar = _progress_bar(pct)
        lines.append(f"| {app} | {pct}% | {bar} |")
        if pct >= 80:
            high_completion.append(app)

    if high_completion:
        lines.append("")
        lines.append(
            "**Apps above 80% completion:** " + ", ".join(high_completion)
        )

    with open('docs/App_Completion_Summary.md', 'w', encoding='utf-8') as md:
        md.write("\n".join(lines) + "\n")
