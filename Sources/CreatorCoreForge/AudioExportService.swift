import Foundation

public enum AudioExportFormat: String {
    case mp3, wav, srt
}

/// Provides higher-level export convenience around `AudioExporter`.
public final class AudioExportService {
    private let exporter: AudioExporter

    public init(exporter: AudioExporter = AudioExporter()) {
        self.exporter = exporter
    }

    public func exportAudio(data: Data, filename: String, format: AudioExportFormat) -> URL? {
        let baseDir = FileManager.default.temporaryDirectory.appendingPathComponent("exports", isDirectory: true)
        try? FileManager.default.createDirectory(at: baseDir, withIntermediateDirectories: true)
        let output = baseDir.appendingPathComponent(filename).appendingPathExtension(format.rawValue)
        switch format {
        case .mp3:
            _ = exporter.exportToMP3(audioData: data, filename: filename)
        case .wav:
            _ = exporter.exportToWAV(audioData: data, filename: filename)
        case .srt:
            try? data.write(to: output)
        }
        return output
    }
}
