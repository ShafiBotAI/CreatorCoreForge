import Foundation

/// Lightweight encrypted vault that stores notes in-memory and
/// logs consent timestamps for each entry. Encryption is a simple
/// XOR operation based on the provided password so the examples
/// remain self contained.
public final class PrivateVault {
    /// Password required for unlocking the vault.
    private let password: String
    /// Timestamp when each entry was added. Parallel array to `entries`.
    private var logs: [Date] = []
    /// Encrypted note payloads.
    private var entries: [Data] = []

    /// Create a new vault secured by `password`.
    public init(password: String) {
        self.password = password
    }

    // MARK: - Types

    /// Supported actions for the unified `handle` API.
    public enum Action {
        case add(String)
        case addBatch([String])
        case remove(index: Int)
        case retrieve(password: String)
        case readmeSummary(url: URL?)
    }

    /// Errors that can be thrown or returned during vault operations.
    public enum VaultError: Error {
        case invalidPassword
        case indexOutOfBounds
        case ioFailure
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

    /// Adds multiple entries at once.
    public func addEntries(_ texts: [String]) {
        for text in texts { addEntry(text) }
    }

    /// Remove the entry at `index`.
    public func removeEntry(at index: Int) throws {
        guard entries.indices.contains(index) else {
            throw VaultError.indexOutOfBounds
        }
        entries.remove(at: index)
        logs.remove(at: index)
    }

    /// Retrieve all entries if the password matches.
    public func retrieveEntries(password: String) throws -> [String] {
        guard password == self.password else { throw VaultError.invalidPassword }
        return entries.map { decrypt($0) }
    }

    /// Access log of when notes were added.
    public var consentLogs: [Date] { logs }

    /// Returns the number of stored entries.
    public var count: Int { entries.count }

    /// Provide a short summary of the README at `url` or in the current directory.
    public func readmeSummary(url: URL? = nil) throws -> String {
        let manager = FileManager.default
        let path: String
        if let url = url { path = url.path } else {
            path = "README.md"
        }
        guard let data = manager.contents(atPath: path),
              let text = String(data: data, encoding: .utf8) else {
            throw VaultError.ioFailure
        }
        let lines = text.split(separator: "\n").map(String.init)
        return lines.prefix(3).joined(separator: " ")
    }

    /// Unified handler that performs various actions and returns human-readable output.
    @discardableResult
    public func handle(_ action: Action) -> Result<[String], VaultError> {
        do {
            switch action {
            case .add(let text):
                addEntry(text)
                return .success([])
            case .addBatch(let texts):
                addEntries(texts)
                return .success([])
            case .remove(let index):
                try removeEntry(at: index)
                return .success([])
            case .retrieve(let pw):
                let items = try retrieveEntries(password: pw)
                return .success(items)
            case .readmeSummary(let url):
                let summary = try readmeSummary(url: url)
                return .success([summary])
            }
        } catch let error as VaultError {
            return .failure(error)
        } catch {
            return .failure(.ioFailure)
        }
    }
}
