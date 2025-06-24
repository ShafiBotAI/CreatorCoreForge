import json
from calc_app_completion import scan_apps
import sys

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
