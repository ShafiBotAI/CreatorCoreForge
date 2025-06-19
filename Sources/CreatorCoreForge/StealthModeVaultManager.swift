import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Manages a local vault for downloaded files with optional stealth mode and PIN protection.
public final class StealthModeVaultManager {
    private let fileManager: FileManager
    private let vaultURL: URL
    private let nsfwVaultURL: URL
    private let pinKey = "VaultPINHash"

    public private(set) var stealthMode = false

    public init(directory: URL? = nil, fileManager: FileManager = .default) {
        self.fileManager = fileManager
        let dir = directory ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.vaultURL = dir.appendingPathComponent("Vault", isDirectory: true)
        self.nsfwVaultURL = dir.appendingPathComponent("NSFWVault", isDirectory: true)
        try? fileManager.createDirectory(at: vaultURL, withIntermediateDirectories: true)
        try? fileManager.createDirectory(at: nsfwVaultURL, withIntermediateDirectories: true)
    }

    /// Set or update the vault PIN. The value is hashed before storage.
    public func setPIN(_ pin: String) {
        let hash = Self.hash(pin)
        UserDefaults.standard.set(hash, forKey: pinKey)
    }

    /// Validate a PIN against the stored hash.
    public func verifyPIN(_ pin: String) -> Bool {
        guard let stored = UserDefaults.standard.string(forKey: pinKey) else { return false }
        return stored == Self.hash(pin)
    }

    public func setStealthMode(_ enabled: Bool) {
        stealthMode = enabled
        updateHiddenAttributes(for: vaultURL, hidden: enabled)
        updateHiddenAttributes(for: nsfwVaultURL, hidden: enabled)
    }

    /// Store a file in either the regular or NSFW vault.
    public func store(url: URL, named name: String, nsfw: Bool = false) throws {
        let destDir = nsfw ? nsfwVaultURL : vaultURL
        let dest = destDir.appendingPathComponent(name)
        if fileManager.fileExists(atPath: dest.path) {
            try fileManager.removeItem(at: dest)
        }
        try fileManager.copyItem(at: url, to: dest)
        if stealthMode {
            try? fileManager.setAttributes([.extensionHidden: true], ofItemAtPath: dest.path)
        }
    }

    public func retrieve(named name: String, nsfw: Bool = false) -> URL? {
        let dir = nsfw ? nsfwVaultURL : vaultURL
        let url = dir.appendingPathComponent(name)
        return fileManager.fileExists(atPath: url.path) ? url : nil
    }

    public func listFiles(nsfw: Bool = false) -> [String] {
        guard !stealthMode else { return [] }
        let dir = nsfw ? nsfwVaultURL : vaultURL
        return (try? fileManager.contentsOfDirectory(atPath: dir.path)) ?? []
    }

    private func updateHiddenAttributes(for directory: URL, hidden: Bool) {
        let attr: [FileAttributeKey: Any] = [.extensionHidden: hidden]
        try? fileManager.setAttributes(attr, ofItemAtPath: directory.path)
        if let files = try? fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) {
            for file in files {
                try? fileManager.setAttributes(attr, ofItemAtPath: file.path)
            }
        }
    }

    private static func hash(_ pin: String) -> String {
        #if canImport(CryptoKit)
        let data = Data(pin.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
        #else
        return String(pin.reversed()) // fallback naive hash
        #endif
    }
}
