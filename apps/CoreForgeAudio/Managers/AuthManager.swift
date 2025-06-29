#if canImport(SwiftUI)
import SwiftUI
#endif
import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Lightweight authentication manager used by the sample app.
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

#if canImport(SwiftUI)
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("email") private var storedEmail: String = ""
    @AppStorage("planTier") private var planTier: String = SubscriptionManager.Plan.free.rawValue
    @AppStorage("userID") private var storedUserID: String = ""
    @AppStorage("userTier") private var storedUserTier: String = SubscriptionManager.Plan.free.rawValue
    @AppStorage("referralCode") private var storedReferral: String = ""
#endif

    private init() {}

    /// Unique ID for the current user.
    var userID: String {
        if storedUserID.isEmpty { storedUserID = UUID().uuidString }
        return storedUserID
    }

    /// Currently selected subscription plan.
    var activePlan: SubscriptionManager.Plan {
        get { SubscriptionManager.Plan(rawValue: planTier) ?? .free }
        set {
            planTier = newValue.rawValue
            storedUserTier = newValue.rawValue
        }
    }

    /// Sign in with existing credentials.
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let hash = Self.hash(password)
        if let stored = SecureStore.password(for: email), stored == hash {
            storedEmail = email
            if storedUserID.isEmpty { storedUserID = UUID().uuidString }
            isLoggedIn = true
            completion(.success(()))
        } else {
            completion(.failure(NSError(domain: "Auth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
        }
    }

    /// Register a new account and immediately log in.
    func signUp(email: String, password: String, plan: SubscriptionManager.Plan = .free, completion: @escaping (Result<Void, Error>) -> Void) {
        guard SecureStore.password(for: email) == nil else {
            completion(.failure(NSError(domain: "Auth", code: 2, userInfo: [NSLocalizedDescriptionKey: "User exists"])))
            return
        }
        let hash = Self.hash(password)
        _ = SecureStore.storePassword(hash, for: email)
        storedEmail = email
        activePlan = plan
        storedUserID = UUID().uuidString
        isLoggedIn = true
        completion(.success(()))
    }

    /// Continue without an account using the free plan.
    func signInAnonymously(completion: @escaping () -> Void) {
        storedEmail = ""
        activePlan = .free
        if storedUserID.isEmpty { storedUserID = UUID().uuidString }
        isLoggedIn = true
        completion()
    }

    /// Simulate sending a password reset email.
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        guard SecureStore.password(for: email) != nil else {
            completion(NSError(domain: "Auth", code: 3, userInfo: [NSLocalizedDescriptionKey: "No such user"]))
            return
        }
        let newHash = Self.hash(UUID().uuidString)
        _ = SecureStore.storePassword(newHash, for: email)
        completion(nil)
    }

    /// Sign out the current user.
    func signOut() {
        isLoggedIn = false
        storedEmail = ""
    }

    /// Basic hash helper for passwords.
    private static func hash(_ str: String) -> String {
#if canImport(CryptoKit)
        let digest = SHA256.hash(data: Data(str.utf8))
        return digest.compactMap { String(format: "%02x", $0) }.joined()
#else
        return String(str.reversed())
#endif
    }
}
