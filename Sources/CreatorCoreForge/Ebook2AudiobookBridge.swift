import Foundation

/// Bridge to run the Python-based `ebook2audiobook` snapshot from Swift.
/// This allows any CoreForge app to invoke the advanced conversion pipeline
/// packaged under `apps/ebook2audiobook`.
public struct Ebook2AudiobookBridge {
    public var scriptPath: String

    /// Initialize the bridge with an optional custom script path.
    public init(scriptPath: String = "apps/ebook2audiobook/app.py") {
        self.scriptPath = scriptPath
    }

    /// Convert the given ebook file to an audiobook using the Python script.
    /// - Parameters:
    ///   - ebook: Path to the input ebook file.
    ///   - outputDirectory: Where the generated audio files will be stored.
    /// - Returns: `true` if the conversion succeeded.
    @discardableResult
    public func convert(ebook: String, outputDirectory: String) -> Bool {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["python3", scriptPath, "--headless", "--ebook", ebook, "--output_dir", outputDirectory]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()
            return process.terminationStatus == 0
        } catch {
            print("Failed to launch ebook2audiobook: \(error)")
            return false
        }
    }
}
