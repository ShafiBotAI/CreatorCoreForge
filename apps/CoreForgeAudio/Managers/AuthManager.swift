#if canImport(SwiftUI)
import SwiftUI
#endif
import Foundation

/// Simple authentication manager storing login state locally.
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

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

    /// Sign in with existing credentials (no validation for this stub).
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        storedEmail = email
        isLoggedIn = true
        completion(.success(()))
    }

    /// Register a new account and immediately log in.
    func signUp(email: String, password: String, plan: SubscriptionManager.Plan, completion: @escaping (Result<Void, Error>) -> Void) {
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
        completion(nil)
    }

    /// Sign out the current user.
    func signOut() {
        isLoggedIn = false
    }
}
