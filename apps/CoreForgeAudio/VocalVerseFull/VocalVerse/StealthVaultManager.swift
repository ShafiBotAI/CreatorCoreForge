import Foundation

/// Handles secure storage of audiobook files with optional stealth mode.
public final class StealthVaultManager {
    private let fileManager: FileManager
    private let vaultURL: URL
    public private(set) var stealthMode = false

    public init(directory: URL? = nil, fileManager: FileManager = .default) {
        self.fileManager = fileManager
        let dir = directory ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.vaultURL = dir.appendingPathComponent("Vault", isDirectory: true)
        try? fileManager.createDirectory(at: vaultURL, withIntermediateDirectories: true)
    }

    /// Enable or disable stealth mode. When enabled the vault is hidden from the Files app.
    public func setStealthMode(_ enabled: Bool) {
        stealthMode = enabled
        let attr: [FileAttributeKey: Any] = [.extensionHidden: enabled]
        try? fileManager.setAttributes(attr, ofItemAtPath: vaultURL.path)
        // Update existing files to respect current setting
        if let files = try? fileManager.contentsOfDirectory(at: vaultURL, includingPropertiesForKeys: nil) {
            for file in files {
                try? fileManager.setAttributes(attr, ofItemAtPath: file.path)
            }
        }
    }

    /// Store a file into the vault directory.
    public func store(url: URL, named name: String) throws {
        let dest = vaultURL.appendingPathComponent(name)
        if fileManager.fileExists(atPath: dest.path) {
            try fileManager.removeItem(at: dest)
        }
        try fileManager.copyItem(at: url, to: dest)
        if stealthMode {
            try? fileManager.setAttributes([.extensionHidden: true], ofItemAtPath: dest.path)
        }
    }

    /// Retrieve a stored file URL if it exists.
    public func retrieve(named name: String) -> URL? {
        let url = vaultURL.appendingPathComponent(name)
        return fileManager.fileExists(atPath: url.path) ? url : nil
    }

    /// List files in the vault when not in stealth mode.
    public func listFiles() -> [String] {
        guard !stealthMode,
              let files = try? fileManager.contentsOfDirectory(atPath: vaultURL.path) else { return [] }
        return files
    }
}
