# Auto-generated for Generate full `.pbxproj` project
def generate_full_pbxproj(path):
    """Create a minimal pbxproj file at the given path."""
    content = "// !PBX project"\
        "\nPBXProject = {}".format(path)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    return path
