import Foundation

/// Handles creator voice uploads for cloning.
public final class CustomVoiceUploads {
    public private(set) var uploaded: [URL] = []
    public init() {}
    public func upload(_ url: URL) {
        uploaded.append(url)
    }
    public func clear() { uploaded.removeAll() }
}
