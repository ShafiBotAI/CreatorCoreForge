#if canImport(SwiftUI)
import SwiftUI
#endif
import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Simple authentication manager storing login state locally.
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

    /// Simple in-memory user store. Keys are emails; values are hashed passwords.
    private var accounts: [String: String] = [:]

    #if canImport(SwiftUI)
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("email") private var storedEmail: String = ""
    @AppStorage("planTier") private var planTier: String = SubscriptionManager.Plan.free.rawValue
    #endif

    private init() {}

    /// Current subscription plan saved in user defaults.
    var activePlan: SubscriptionManager.Plan {
        get { SubscriptionManager.Plan(rawValue: planTier) ?? .free }
        set { planTier = newValue.rawValue }
    }

    /// Sign in with existing credentials.
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let stored = accounts[email], stored == Self.hash(password) else {
            completion(.failure(NSError(domain: "Auth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
            return
        }
        storedEmail = email
        isLoggedIn = true
        completion(.success(()))
    }

    /// Register a new account and immediately log in.
    func signUp(email: String, password: String, plan: SubscriptionManager.Plan, completion: @escaping (Result<Void, Error>) -> Void) {
        guard accounts[email] == nil else {
            completion(.failure(NSError(domain: "Auth", code: 2, userInfo: [NSLocalizedDescriptionKey: "User exists"])))
            return
        }
        accounts[email] = Self.hash(password)
        storedEmail = email
        activePlan = plan
        isLoggedIn = true
        completion(.success(()))
    }

    /// Continue without an account using the free plan.
    func signInAnonymously(completion: @escaping () -> Void) {
        storedEmail = ""
        activePlan = .free
        isLoggedIn = true
        completion()
    }

    /// Simulate sending a password reset email.
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        guard accounts[email] != nil else {
            completion(NSError(domain: "Auth", code: 3, userInfo: [NSLocalizedDescriptionKey: "No such user"]))
            return
        }
        accounts[email] = Self.hash(UUID().uuidString)
        completion(nil)
    }

    /// Sign out the current user.
    func signOut() {
        isLoggedIn = false
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
