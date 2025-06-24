import Foundation

/// Creates downloadable audiobook files from audio chapters.
public final class DownloadableAudiobookCreator {
    private let compiler: AudiobookCompiler

    public init(compiler: AudiobookCompiler = AudiobookCompiler()) {
        self.compiler = compiler
    }

    /// Generates a downloadable audiobook ZIP file.
    public func createDownloadableAudiobook(chapters: [URL], metadata: Metadata) -> URL {
        return compiler.compileAudiobook(chapters: chapters, metadata: metadata, cover: nil)
    }
}
