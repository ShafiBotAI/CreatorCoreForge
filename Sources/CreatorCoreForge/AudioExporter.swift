import Foundation

/// Optional metadata tags to embed alongside exported audio files.
public struct AudioMetadata: Codable {
    public var narrator: String?
    public var chapter: Int?
    public var genre: String?
    public var fx: String?

    public init(narrator: String? = nil,
                chapter: Int? = nil,
                genre: String? = nil,
                fx: String? = nil) {
        self.narrator = narrator
        self.chapter = chapter
        self.genre = genre
        self.fx = fx
    }
}

/// Options for customizing multitrack export behavior.
public struct ExportOptions {
    /// Include the ambient track in the exported archive.
    public var includeAmbient: Bool
    /// Include the FX/NSFW track in the exported archive.
    public var includeFX: Bool

    public init(includeAmbient: Bool = true, includeFX: Bool = true) {
        self.includeAmbient = includeAmbient
        self.includeFX = includeFX
    }
}

/// Handles exporting audio data into various formats and packaging options.
public final class AudioExporter {
    private let exportDirectory: URL

    public init(directory: URL? = nil) {
        let base = directory ?? FileManager.default.temporaryDirectory
        exportDirectory = base.appendingPathComponent("exports", isDirectory: true)
        try? FileManager.default.createDirectory(at: exportDirectory, withIntermediateDirectories: true)
    }

    /// Estimate the size in bytes of the exported file.
    public func previewFileSize(for audioData: Data, format: String) -> Int {
        // for now, file size matches data size with minor header difference
        // using a simple heuristic rather than actual encoding
        let headerOverhead = 512
        return audioData.count + headerOverhead
    }

    /// Export the provided audio data as an MP3 file with optional metadata.
    /// - Returns: `true` if the write succeeded.
    @discardableResult
    public func exportToMP3(audioData: Data, filename: String, metadata: AudioMetadata? = nil) -> Bool {
        let output = exportDirectory.appendingPathComponent(filename).appendingPathExtension("mp3")
        print("\u{1F4E4} Exporting MP3 to: \(output.path)")
        do {
            try audioData.write(to: output)
            if let meta = metadata { writeMetadata(meta, for: output) }
            return true
        } catch {
            print("Failed to export MP3: \(error)")
            return false
        }
    }

    /// Export the provided audio data as a WAV file with optional metadata.
    /// - Returns: `true` if the write succeeded.
    @discardableResult
    public func exportToWAV(audioData: Data, filename: String, metadata: AudioMetadata? = nil) -> Bool {
        let output = exportDirectory.appendingPathComponent(filename).appendingPathExtension("wav")
        print("\u{1F4E4} Exporting WAV to: \(output.path)")
        do {
            try audioData.write(to: output)
            if let meta = metadata { writeMetadata(meta, for: output) }
            return true
        } catch {
            print("Failed to export WAV: \(error)")
            return false
        }
    }

    /// Export the provided audio data as a FLAC file with optional metadata.
    /// - Returns: `true` if the write succeeded.
    @discardableResult
    public func exportToFLAC(audioData: Data, filename: String, metadata: AudioMetadata? = nil) -> Bool {
        let output = exportDirectory.appendingPathComponent(filename).appendingPathExtension("flac")
        print("\u{1F4E4} Exporting FLAC to: \(output.path)")
        do {
            try audioData.write(to: output)
            if let meta = metadata { writeMetadata(meta, for: output) }
            return true
        } catch {
            print("Failed to export FLAC: \(error)")
            return false
        }
    }

    /// Export separate voice, ambient, and FX tracks as a multitrack bundle.
    /// Returns path to the zipped archive containing the tracks and metadata.
    public func exportMultitrack(voice: Data,
                                 ambient: Data? = nil,
                                 fx: Data? = nil,
                                 baseName: String,
                                 metadata: AudioMetadata? = nil,
                                 options: ExportOptions = ExportOptions()) -> String? {
        let voicePath = exportDirectory.appendingPathComponent(baseName + "_voice.wav")
        let ambientPath = ambient != nil ? exportDirectory.appendingPathComponent(baseName + "_ambient.wav") : nil
        let fxPath = fx != nil ? exportDirectory.appendingPathComponent(baseName + "_fx.wav") : nil

        do {
            try voice.write(to: voicePath)
            if options.includeAmbient, let a = ambient, let path = ambientPath {
                try a.write(to: path)
            }
            if options.includeFX, let f = fx, let path = fxPath {
                try f.write(to: path)
            }
            if let meta = metadata { writeMetadata(meta, for: voicePath.deletingPathExtension()) }
            var files = [voicePath.path]
            if options.includeAmbient, let path = ambientPath?.path { files.append(path) }
            if options.includeFX, let path = fxPath?.path { files.append(path) }
            return compressToZip(filePaths: files, zipName: baseName)
        } catch {
            print("Failed to export multitrack: \(error)")
            return nil
        }
    }

    /// Compress a set of file paths into a zip archive in the export directory.
    /// - Returns: Path to the created zip file.
    public func compressToZip(filePaths: [String], zipName: String) -> String {
        let zipPath = exportDirectory
            .appendingPathComponent(zipName)
            .appendingPathExtension("zip")
        print("\u{1F4DC} Compressing files into: \(zipPath.path)")
        let tempDir = exportDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: tempDir,
                                                    withIntermediateDirectories: true)
            for path in filePaths {
                let src = URL(fileURLWithPath: path)
                let dst = tempDir.appendingPathComponent(src.lastPathComponent)
                try FileManager.default.copyItem(at: src, to: dst)
            }
            #if canImport(Compression)
            try FileManager.default.zipItem(at: tempDir, to: zipPath)
            #elseif os(macOS) || os(Linux)
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/zip")
            process.currentDirectoryURL = tempDir
            process.arguments = ["-r", zipPath.path, "."]
            try process.run()
            process.waitUntilExit()
            #else
            print("Compression framework unavailable on this platform")
            #endif
            try FileManager.default.removeItem(at: tempDir)
        } catch {
            print("Failed to zip files: \(error)")
        }
        return zipPath.path
    }

    private func writeMetadata(_ metadata: AudioMetadata, for audioURL: URL) {
        let metaURL = audioURL.appendingPathExtension("json")
        if let data = try? JSONEncoder().encode(metadata) {
            try? data.write(to: metaURL)
        }
    }
}
