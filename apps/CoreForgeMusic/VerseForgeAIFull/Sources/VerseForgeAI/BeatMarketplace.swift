import Foundation

public final class BeatMarketplace {
    private var beats: [String: URL] = [:] // name -> download URL

    /// Create a marketplace and optionally preload bundled beats from
    /// `beats.json` in the module resources.
    public init(loadDefaults: Bool = true) {
        if loadDefaults {
            loadDefaultBeats()
        }
    }

    public func addBeat(name: String, url: URL) {
        beats[name] = url
    }

    public func listBeats() -> [String] {
        Array(beats.keys)
    }

    public func urlForBeat(_ name: String) -> URL? {
        beats[name]
    }

    private struct BeatInfo: Decodable {
        let name: String
        let url: URL
    }

    /// Load beats packaged with the target. Called from the initializer.
    private func loadDefaultBeats() {
        guard let url = Bundle.module.url(forResource: "beats", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let beatInfos = try? JSONDecoder().decode([BeatInfo].self, from: data) else {
            return
        }
        for info in beatInfos {
            beats[info.name] = info.url
        }
    }
}
