import Foundation

/// Simple in-memory auth for demo and testing purposes.
public final class BasicAuthService {
    public static let shared = BasicAuthService()

    public struct User {
        public let email: String
        public let dob: Date
    }

    private(set) public var currentUser: User?

    private init() {}

    /// Register a user and automatically sign them in.
    public func register(email: String, password: String, dob: Date) {
        currentUser = User(email: email, dob: dob)
    }

    /// Sign in if credentials match the registered user.
    @discardableResult
    public func signIn(email: String, password: String) -> Bool {
        guard let user = currentUser, user.email == email else { return false }
        return true
    }
}
