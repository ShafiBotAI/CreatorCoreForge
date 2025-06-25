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

    /// Stream audio data to disk as it arrives and return the final file URL.
    @available(macOS 12.0, iOS 15.0, *)
    public func exportLive<S: AsyncSequence>(_ stream: S, to url: URL) async throws -> URL where S.Element == Data {
        let handle = try FileHandle(forWritingTo: url)
        for try await chunk in stream {
            try handle.write(contentsOf: chunk)
        }
        try handle.close()
        return url
    }
}
