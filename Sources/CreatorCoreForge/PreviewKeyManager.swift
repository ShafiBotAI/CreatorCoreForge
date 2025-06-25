import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Generates and validates encrypted preview keys for private scenes.
public struct PreviewKeyManager {
    public init() {}

    /// Create a preview key using SHA256 of the scene identifier and a salt.
    public func generateKey(for sceneID: String, salt: String = "coreforge") -> String {
        let input = sceneID + salt
        #if canImport(CryptoKit)
        let data = Data(input.utf8)
        let digest = SHA256.hash(data: data)
        return digest.compactMap { String(format: "%02x", $0) }.joined()
        #else
        return String(input.reversed())
        #endif
    }

    /// Validate the preview key matches the scene identifier and salt.
    public func validate(key: String, sceneID: String, salt: String = "coreforge") -> Bool {
        generateKey(for: sceneID, salt: salt) == key
    }
}
