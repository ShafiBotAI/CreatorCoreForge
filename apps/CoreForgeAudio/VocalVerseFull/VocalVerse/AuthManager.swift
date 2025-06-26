import Foundation
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif
#if canImport(Combine)
import Combine
#endif

// Guard FirebaseAuth availability so the project can build on platforms
// without the Firebase SDK (e.g. Linux CI containers).
#if canImport(FirebaseAuth) && canImport(Combine)
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published private(set) var currentUser: User?

    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    private init() {
        currentUser = Auth.auth().currentUser
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUser = user
        }
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - Account Creation

    func signUp(email: String,
                password: String,
                displayName: String? = nil,
                completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let user = try await signUp(email: email,
                                           password: password,
                                           displayName: displayName)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let user = try await signIn(email: email, password: password)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func signIn(email: String, password: String, dob: Date, completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let user = try await signIn(email: email, password: password, dob: dob)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func signIn(email: String, password: String, code: String, completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let user = try await signIn(email: email, password: password, code: code)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String) async throws -> User {
        try await signIn(email: email, password: password, dob: Date())
    }

    @available(iOS 15.0, *)
    func signUp(email: String,
                password: String,
                displayName: String? = nil) async throws -> User {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = authResult.user
        if let name = displayName {
            let change = user.createProfileChangeRequest()
            change.displayName = name
            try await change.commitChanges()
        }
        try await user.sendEmailVerification()
        currentUser = user
        return user
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String, dob: Date) async throws -> User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = authResult.user
        if !user.isEmailVerified {
            try await user.sendEmailVerification()
            throw NSError(domain: "Auth", code: -2, userInfo: [NSLocalizedDescriptionKey: "Email not verified. Verification sent."])
        }
        guard Calendar.current.dateComponents([.year], from: dob, to: Date()).year ?? 0 >= 18 else {
            throw NSError(domain: "Auth", code: -3, userInfo: [NSLocalizedDescriptionKey: "User is underage"])
        }
        currentUser = user
        return user
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String, code: String) async throws -> User {
        let user = try await signIn(email: email, password: password)
        guard code == "000000" else {
            throw NSError(domain: "Auth", code: -4, userInfo: [NSLocalizedDescriptionKey: "Invalid code"])
        }
        return user
    }

    func signInAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let user = try await signInAnonymously()
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }

    @available(iOS 15.0, *)
    func signInAnonymously() async throws -> User {
        let authResult = try await Auth.auth().signInAnonymously()
        let user = authResult.user
        currentUser = user
        return user
    }

    func signOut() throws {
        try Auth.auth().signOut()
        currentUser = nil
    }
}
#else
/// Minimal stub used when FirebaseAuth or Combine is unavailable. This allows
/// the rest of the codebase to compile without modification on platforms where
/// Firebase is not supported.
final class AuthManager {
    static let shared = AuthManager()
    private(set) var currentUser: Any?
    private init() {}

    func signUp(email: String, password: String, displayName: String? = nil, completion: @escaping (Result<Any, Error>) -> Void) {
        completion(.failure(NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "FirebaseAuth unavailable"])))
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Any, Error>) -> Void) {
        completion(.failure(NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "FirebaseAuth unavailable"])))
    }

    func signOut() throws {
        currentUser = nil
    }
}
#endif
