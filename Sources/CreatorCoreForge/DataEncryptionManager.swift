import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Provides simple data encryption and decryption utilities.
public struct DataEncryptionManager {
    public init() {}

    #if canImport(CryptoKit)
    /// Encrypts the given data with the provided symmetric key.
    public func encrypt(_ data: Data, using key: SymmetricKey) throws -> Data {
        let sealed = try AES.GCM.seal(data, using: key)
        return sealed.combined!
    }

    /// Decrypts the given data with the provided symmetric key.
    public func decrypt(_ data: Data, using key: SymmetricKey) throws -> Data {
        let box = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(box, using: key)
    }

    /// Encrypts a file to the provided output URL.
    @discardableResult
    public func encryptFile(at input: URL, output: URL, key: SymmetricKey) throws -> URL {
        let data = try Data(contentsOf: input)
        let encrypted = try encrypt(data, using: key)
        try encrypted.write(to: output)
        return output
    }

    /// Decrypts a file from the provided URL.
    @discardableResult
    public func decryptFile(at input: URL, output: URL, key: SymmetricKey) throws -> URL {
        let data = try Data(contentsOf: input)
        let decrypted = try decrypt(data, using: key)
        try decrypted.write(to: output)
        return output
    }
    #else
    /// Fallback encryption using simple byte reversal.
    public func encrypt(_ data: Data) -> Data { Data(data.reversed()) }

    /// Fallback decryption using simple byte reversal.
    public func decrypt(_ data: Data) -> Data { Data(data.reversed()) }

    @discardableResult
    public func encryptFile(at input: URL, output: URL) throws -> URL {
        let data = try Data(contentsOf: input)
        let encrypted = encrypt(data)
        try encrypted.write(to: output)
        return output
    }

    @discardableResult
    public func decryptFile(at input: URL, output: URL) throws -> URL {
        let data = try Data(contentsOf: input)
        let decrypted = decrypt(data)
        try decrypted.write(to: output)
        return output
    }
    #endif
}
