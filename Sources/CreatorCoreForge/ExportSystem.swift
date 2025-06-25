import Foundation

/// Handles batch and single-file exports to MP3/WAV formats.
public final class ExportSystem {
    public init() {}

    /// Export a single audio blob to an MP3 file.
    public func exportMP3(data: Data, to url: URL) throws {
        try data.write(to: url)
    }

    /// Export a single audio blob to a WAV file.
    public func exportWAV(data: Data, to url: URL) throws {
        try data.write(to: url)
    }

    /// Export multiple audio blobs as numbered WAV files in the destination directory.
    @discardableResult
    public func exportBatch(_ tracks: [Data], to directory: URL) throws -> [URL] {
        var urls: [URL] = []
        for (index, data) in tracks.enumerated() {
            let url = directory.appendingPathComponent("track\(index).wav")
            try data.write(to: url)
            urls.append(url)
        }
        return urls
    }
}
