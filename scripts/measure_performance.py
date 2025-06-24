import argparse
import subprocess
import psutil
import time
import json


def run_and_measure(cmd):
    proc = psutil.Process()
    mem_before = proc.memory_info().rss
    start = time.perf_counter()
    completed = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    end = time.perf_counter()
    mem_after = proc.memory_info().rss
    return {
        "cmd": cmd,
        "returncode": completed.returncode,
        "latency_sec": round(end - start, 3),
        "memory_before_mb": round(mem_before / (1024 * 1024), 2),
        "memory_after_mb": round(mem_after / (1024 * 1024), 2),
        "stdout": completed.stdout[:200],
        "stderr": completed.stderr[:200],
    }


def main():
    parser = argparse.ArgumentParser(description="Measure command memory and latency")
    parser.add_argument('command', nargs=argparse.REMAINDER)
    parser.add_argument('-o', '--output', default='performance_metrics.json')
    args = parser.parse_args()

    if not args.command:
        print("No command provided")
        return
    cmd_str = ' '.join(args.command)
    result = run_and_measure(cmd_str)

    try:
        with open(args.output, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=2)
    except Exception as e:
        print(f"Failed to write report: {e}")
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
