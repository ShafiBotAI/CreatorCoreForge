#!/usr/bin/env python3
import os
import re
import argparse

TASK_PATTERN = re.compile(r"^-\s*\[ \]\s*(.+)")


def parse_tasks(agent_path: str):
    tasks = []
    with open(agent_path, 'r', encoding='utf-8') as f:
        for line in f:
            match = TASK_PATTERN.match(line.strip())
            if match:
                tasks.append(match.group(1))
    return tasks


def aggregate_tasks(repo_root: str):
    all_tasks = {}
    for root, dirs, files in os.walk(repo_root):
        if 'AGENTS.md' in files:
            path = os.path.join(root, 'AGENTS.md')
            tasks = parse_tasks(path)
            if tasks:
                rel = os.path.relpath(root, repo_root)
                all_tasks[rel] = tasks
    return all_tasks


def main():
    parser = argparse.ArgumentParser(description='Aggregate open tasks from AGENTS.md files.')
    parser.add_argument('repo_root', nargs='?', default='.')
    parser.add_argument('-o', '--output', default='docs/GLOBAL_TASK_SUMMARY.md')
    args = parser.parse_args()

    tasks_map = aggregate_tasks(os.path.abspath(args.repo_root))

    with open(args.output, 'w', encoding='utf-8') as f:
        f.write('# Global Task Summary\n\n')
        for section in sorted(tasks_map.keys()):
            f.write(f'## {section}\n')
            for task in tasks_map[section]:
                f.write(f'- {task}\n')
            f.write('\n')
    print(f'Generated {args.output}')


if __name__ == '__main__':
    main()
