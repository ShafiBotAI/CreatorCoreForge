import Foundation
#if canImport(SwiftUI)
import SwiftUI
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

    /// Sign in with an email and password. Always succeeds in this demo.
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        storedEmail = email
        if storedUserID.isEmpty { storedUserID = UUID().uuidString }
        isLoggedIn = true
        completion(.success(()))
    }

    /// Register a new account and immediately log in.
    func signUp(email: String, password: String, plan: SubscriptionManager.Plan = .free, completion: @escaping (Result<Void, Error>) -> Void) {
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

    /// Simulate password reset via email.
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }

    /// Sign out the current user.
    func signOut() {
        isLoggedIn = false
        storedEmail = ""
    }
}
