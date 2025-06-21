import XCTest
@testable import CreatorCoreForge
#if canImport(CryptoKit)
import CryptoKit
#endif

final class DataEncryptionManagerTests: XCTestCase {
    func testEncryptDecryptRoundTrip() throws {
        let manager = DataEncryptionManager()
        #if canImport(CryptoKit)
        let key = SymmetricKey(size: .bits256)
        let data = "Hello".data(using: .utf8)!
        let encrypted = try manager.encrypt(data, using: key)
        let decrypted = try manager.decrypt(encrypted, using: key)
        XCTAssertEqual(decrypted, data)
        #else
        let data = "Hello".data(using: .utf8)!
        let encrypted = manager.encrypt(data)
        let decrypted = manager.decrypt(encrypted)
        XCTAssertEqual(decrypted, data)
        #endif
    }

    func testEncryptDecryptFile() throws {
        let manager = DataEncryptionManager()
        let tmp = FileManager.default.temporaryDirectory
        let input = tmp.appendingPathComponent("input.txt")
        let encryptedURL = tmp.appendingPathComponent("enc.bin")
        let output = tmp.appendingPathComponent("output.txt")
        try "secret".data(using: .utf8)?.write(to: input)
        #if canImport(CryptoKit)
        let key = SymmetricKey(size: .bits256)
        try manager.encryptFile(at: input, output: encryptedURL, key: key)
        try manager.decryptFile(at: encryptedURL, output: output, key: key)
        #else
        try manager.encryptFile(at: input, output: encryptedURL)
        try manager.decryptFile(at: encryptedURL, output: output)
        #endif
        let decrypted = try String(contentsOf: output)
        XCTAssertEqual(decrypted, "secret")
    }
}
