import Foundation

/// Handles exporting audio data into various formats and packaging options.
public final class AudioExporter {
    private let exportDirectory: URL

    public init(directory: URL? = nil) {
        let base = directory ?? FileManager.default.temporaryDirectory
        exportDirectory = base.appendingPathComponent("exports", isDirectory: true)
        try? FileManager.default.createDirectory(at: exportDirectory, withIntermediateDirectories: true)
    }

    /// Export the provided audio data as an MP3 file.
    /// - Returns: `true` if the write succeeded.
    @discardableResult
    public func exportToMP3(audioData: Data, filename: String) -> Bool {
        let output = exportDirectory.appendingPathComponent(filename).appendingPathExtension("mp3")
        print("\u{1F4E4} Exporting MP3 to: \(output.path)")
        do {
            try audioData.write(to: output)
            return true
        } catch {
            print("Failed to export MP3: \(error)")
            return false
        }
    }

    /// Export the provided audio data as a WAV file.
    /// - Returns: `true` if the write succeeded.
    @discardableResult
    public func exportToWAV(audioData: Data, filename: String) -> Bool {
        let output = exportDirectory.appendingPathComponent(filename).appendingPathExtension("wav")
        print("\u{1F4E4} Exporting WAV to: \(output.path)")
        do {
            try audioData.write(to: output)
            return true
        } catch {
            print("Failed to export WAV: \(error)")
            return false
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
}
