import Foundation
#if canImport(Security)
import Security
#endif

struct SecureStore {
    static func apiKey(named name: String) -> String? {
        if let env = ProcessInfo.processInfo.environment[name] {
            return env
        }
        #if canImport(Security)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let data = item as? Data,
           let key = String(data: data, encoding: .utf8) {
            return key
        }
        #endif
        return nil
    }

    /// Stores the provided API key in the Keychain under the given name.
    /// If a value already exists it will be replaced.
    @discardableResult
    static func storeApiKey(_ key: String, named name: String) -> Bool {
        #if canImport(Security)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name
        ]
        SecItemDelete(query as CFDictionary)
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name,
            kSecValueData as String: key.data(using: .utf8) ?? Data()
        ]
        return SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess
        #else
        return false
        #endif

    /// Retrieve a stored password hash for the given email.
    static func password(for email: String) -> String? {
        apiKey(named: "auth_\(email)")
    }

    /// Store a password hash in the Keychain under the email key.
    @discardableResult
    static func storePassword(_ hash: String, for email: String) -> Bool {
        storeApiKey(hash, named: "auth_\(email)")
    }
}
