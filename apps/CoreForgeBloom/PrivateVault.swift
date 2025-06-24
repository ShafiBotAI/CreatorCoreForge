import Foundation

/// Lightweight encrypted vault that stores notes in-memory and
/// logs consent timestamps for each entry. Encryption is a simple
/// XOR operation based on the provided password so the examples
/// remain self contained.
public final class PrivateVault {
    private let password: String
    private var logs: [Date] = []
    private var entries: [Data] = []

    /// Create a new vault secured by `password`.
    public init(password: String) {
        self.password = password
    }

    // MARK: - Private helpers
    private var keyBytes: [UInt8] { Array(password.utf8) }

    private func encrypt(_ text: String) -> Data {
        let textBytes = Array(text.utf8)
        let key = keyBytes
        let encrypted = textBytes.enumerated().map { idx, byte in
            byte ^ key[idx % key.count]
        }
        return Data(encrypted)
    }

    private func decrypt(_ data: Data) -> String {
        let key = keyBytes
        let decrypted = data.enumerated().map { idx, byte in
            byte ^ key[idx % key.count]
        }
        return String(bytes: decrypted, encoding: .utf8) ?? ""
    }

    // MARK: - Public API
    /// Adds a private note and records consent time.
    public func addEntry(_ text: String) {
        entries.append(encrypt(text))
        logs.append(Date())
    }

    /// Retrieve all entries if the password matches.
    public func retrieveEntries(password: String) -> [String]? {
        guard password == self.password else { return nil }
        return entries.map { decrypt($0) }
    }

    /// Access log of when notes were added.
    public var consentLogs: [Date] { logs }

    /// Returns the number of stored entries.
    public var count: Int { entries.count }
}
