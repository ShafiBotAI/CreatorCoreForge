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

#if canImport(UIKit)
import UIKit
#endif

extension AudiobookCompiler {
#if canImport(UIKit)
    /// Compiles chapters into a zipped audiobook package including metadata and optional cover art.
    public func compileAudiobook(chapters: [URL], metadata: Metadata, cover: UIImage?) -> URL {
        return compileAudiobook(chapters: chapters, metadata: metadata, coverData: cover?.pngData())
    }
#else
    /// Compiles chapters into a zipped audiobook package including metadata. Cover art is ignored on this platform.
    public func compileAudiobook(chapters: [URL], metadata: Metadata, cover: Any?) -> URL {
        return compileAudiobook(chapters: chapters, metadata: metadata, coverData: nil)
    }
#endif

    private func compileAudiobook(chapters: [URL], metadata: Metadata, coverData: Data?) -> URL {
        let workDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: workDir, withIntermediateDirectories: true)
        for url in chapters {
            let dest = workDir.appendingPathComponent(url.lastPathComponent)
            try? FileManager.default.copyItem(at: url, to: dest)
        }
        let metaURL = workDir.appendingPathComponent("metadata.json")
        if let data = try? JSONEncoder().encode(metadata) {
            try? data.write(to: metaURL)
        }
        if let cData = coverData {
            let coverURL = workDir.appendingPathComponent("cover.png")
            try? cData.write(to: coverURL)
        }
        let files = (try? FileManager.default.contentsOfDirectory(atPath: workDir.path).map { workDir.appendingPathComponent($0).path }) ?? []
        let zipPath = exporter.compressToZip(filePaths: files, zipName: metadata.title.replacingOccurrences(of: " ", with: "_"))
        return URL(fileURLWithPath: zipPath)
    }
}
