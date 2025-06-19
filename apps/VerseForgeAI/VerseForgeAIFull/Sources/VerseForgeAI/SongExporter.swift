import Foundation

/// Exports generated songs to disk and returns the file location.
public struct SongExporter {
    public init() {}

    public func export(data: Data, named name: String, to directory: URL) throws -> URL {
        let url = directory.appendingPathComponent(name)
        try data.write(to: url)
        return url
    }
}
