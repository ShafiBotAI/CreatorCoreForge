import sys
import re

HEADER_SETTING = "HEADERMAP_STYLE = FLAT;"


def update_pbxproj(path: str) -> bool:
    updated = False
    with open(path) as f:
        lines = f.readlines()
    new_lines = []
    pattern = re.compile(r"\bbuildSettings\s*=\s*{")
    for idx, line in enumerate(lines):
        new_lines.append(line)
        if pattern.search(line):
            indent = re.match(r"\s*", line).group(0)
            indent_next = indent + "\t"
            new_lines.append(f"{indent_next}{HEADER_SETTING}\n")
            updated = True
    if updated:
        with open(path, "w") as f:
            f.writelines(new_lines)
    return updated


def main():
    if len(sys.argv) < 2:
        print("Usage: update_header_map_style.py <pbxproj paths>")
        sys.exit(1)
    for pbxproj in sys.argv[1:]:
        if update_pbxproj(pbxproj):
            print(f"Updated {pbxproj}")

if __name__ == "__main__":
    main()
