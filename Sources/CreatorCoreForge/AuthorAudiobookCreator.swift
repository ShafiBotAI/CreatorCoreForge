import Foundation

/// Service for authors to convert uploaded books into downloadable audiobooks.
public final class AuthorAudiobookCreator {
    private let importer: BookImporter
    private let exportService: AudioExportService
    private let compiler: AudiobookCompiler

    public init(importer: BookImporter,
                exportService: AudioExportService = AudioExportService(),
                compiler: AudiobookCompiler = AudiobookCompiler()) {
        self.importer = importer
        self.exportService = exportService
        self.compiler = compiler
    }

    /// Generate audio chapters for the given book. The returned URLs point to
    /// ACX compliant MP3 files.
    public func generateChapters(from file: URL) async throws -> [URL] {
        let chapters = try await BookImporter.importBook(from: file)
        var urls: [URL] = []
        for (index, chapter) in chapters.enumerated() {
            let data = Data(("ACXHDR" + chapter.text).utf8)
            if let url = exportService.exportAudio(data: data,
                                                   filename: "chapter_\(index)",
                                                   format: .mp3) {
                urls.append(url)
            }
        }
        return urls
    }

    /// Compile chapters into a single audiobook archive.
    public func createAudiobook(from file: URL) async throws -> URL {
        let chapters = try await generateChapters(from: file)
        let meta = Metadata(title: file.deletingPathExtension().lastPathComponent,
                            author: "Author")
        return compiler.compileAudiobook(chapters: chapters, metadata: meta, cover: nil)
    }
}
