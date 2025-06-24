import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Verifies user age and simple ID validation for unlocking NSFW content.
public struct AgeIDVerifier {
    private let idKey = "AgeIDVerifierIDHash"
    private let store: UserDefaults

    public init(store: UserDefaults = .standard) {
        self.store = store
    }

    /// Returns true if the birthdate meets the minimum age requirement and
    /// the provided ID number passes basic validation rules.
    public func verify(birthdate: Date, idNumber: String, minimumAge: Int = 18) -> Bool {
        guard DOBCheck.isOfAge(birthdate: birthdate, minimumAge: minimumAge) else { return false }
        guard Self.isValid(idNumber: idNumber) else { return false }
        store.set(Self.hash(idNumber), forKey: idKey)
        return true
    }

    /// Returns true if an ID was previously verified.
    public var isVerified: Bool {
        store.string(forKey: idKey) != nil
    }

    private static func isValid(idNumber: String) -> Bool {
        let trimmed = idNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let digits = trimmed.filter("0123456789".contains)
        return digits.count >= 6
    }

    private static func hash(_ id: String) -> String {
        #if canImport(CryptoKit)
        let data = Data(id.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
        #else
        return String(id.reversed())
        #endif
    }
}
