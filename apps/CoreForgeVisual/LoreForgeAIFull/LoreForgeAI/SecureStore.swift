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
        return nil // no key available
    }
}
