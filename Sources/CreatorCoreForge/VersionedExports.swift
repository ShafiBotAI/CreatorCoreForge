import Foundation

/// Tracks export versions for audio files.
public final class VersionedExports {
    private var versions: [String] = []
    public init() {}

    public func addVersion(_ tag: String) {
        versions.append(tag)
    }

    public var allVersions: [String] { versions }
}
