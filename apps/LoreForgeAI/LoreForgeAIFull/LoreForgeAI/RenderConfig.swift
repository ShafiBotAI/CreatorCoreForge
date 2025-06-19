import Foundation

struct RenderConfig {
    static private(set) var presets: [String] = [
        "Anime",
        "Live Action",
        "Storyboard",
        "Realistic",
        "Comic",
        "Watercolor",
        "3D CGI",
        "Pixel Art",
        "Sketch"
    ]

    static func addPreset(_ preset: String) {
        guard !presets.contains(preset) else { return }
        presets.append(preset)
    }
}
