import Foundation

/// Compiles a series of audio chapter files into a single downloadable bundle.
public final class AudiobookCompiler {
    private let exporter: AudioExporter

    public init(exporter: AudioExporter = AudioExporter()) {
        self.exporter = exporter
    }

    /// Compresses the provided chapter file paths into a zip and returns
    /// the path to the archive.
    public func compile(chapterFiles: [String], name: String) -> String {
        return exporter.compressToZip(filePaths: chapterFiles, zipName: name)
    }
}
