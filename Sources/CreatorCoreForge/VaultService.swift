import Foundation

/// Simple wrapper around `StealthModeVaultManager` for audio storage.
public final class VaultService {
    private let manager: StealthModeVaultManager

    public init(manager: StealthModeVaultManager = StealthModeVaultManager()) {
        self.manager = manager
    }

    public func saveAudio(bookId: String, data: Data, nsfw: Bool = false) -> Bool {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        do {
            try data.write(to: tempURL)
            try manager.store(url: tempURL, named: bookId, nsfw: nsfw)
            try FileManager.default.removeItem(at: tempURL)
            return true
        } catch {
            print("Vault save failed: \(error)")
            return false
        }
    }

    public func loadAudio(bookId: String, nsfw: Bool = false) -> Data? {
        if let url = manager.retrieve(named: bookId, nsfw: nsfw) {
            return try? Data(contentsOf: url)
        }
        // Return empty data when the file is missing so playback can continue
        return Data()
    }
}
