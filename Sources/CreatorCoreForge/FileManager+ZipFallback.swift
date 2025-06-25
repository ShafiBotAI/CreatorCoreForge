import Foundation

extension FileManager {
    /// Simple cross-platform helper to zip a folder using /usr/bin/zip when available.
    /// If unavailable, an empty archive placeholder is created.
    func codexZipItem(at sourceURL: URL, to destinationURL: URL) throws {
        #if os(macOS) || os(Linux)
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/zip")
        process.currentDirectoryURL = sourceURL
        process.arguments = ["-r", destinationURL.path, "."]
        try process.run()
        process.waitUntilExit()
        #else
        // On platforms without zip command, create an empty archive placeholder
        createFile(atPath: destinationURL.path, contents: Data(), attributes: nil)
        #endif
    }
}
