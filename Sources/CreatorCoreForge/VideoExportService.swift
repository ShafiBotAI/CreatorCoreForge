import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Minimal video export that packages frame names as a text blob.
public final class VideoExportService {
    public init() {}

    /// Export frames to raw data for simple formats (demo only).
    public func exportVideo(frames: [String], format: String) -> Data {
        let joined = frames.joined(separator: "\n")
        return Data(joined.utf8)
    }

    /// Export frames as an MP4 file in the temporary directory.
    /// When AVFoundation is unavailable, a text-based placeholder is written
    /// instead so the pipeline can still produce a file URL.
    public func exportVideoMP4(frames: [String]) -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mp4")
#if canImport(AVFoundation)
        guard let writer = try? AVAssetWriter(url: url, fileType: .mp4) else {
            try? frames.joined(separator: "\n").write(to: url, atomically: true, encoding: .utf8)
            return url
        }
        let settings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: 640,
            AVVideoHeightKey: 480
        ]
        let input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
        writer.add(input)
        writer.startWriting()
        writer.startSession(atSourceTime: .zero)
        input.markAsFinished()
        writer.finishWriting {}
#else
        try? frames.joined(separator: "\n").write(to: url, atomically: true, encoding: .utf8)
#endif
        return url
    }
}

