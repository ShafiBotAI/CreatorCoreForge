import Foundation

/// Basic searchable index for audio files.
public final class AudioSearchIndex {
    private var index: [String: URL] = [:]
    public init() {}

    public func indexFile(_ url: URL, keywords: [String]) {
        for word in keywords { index[word] = url }
    }

    public func search(_ keyword: String) -> URL? {
        index[keyword]
    }
}
