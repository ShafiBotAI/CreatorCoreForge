#if canImport(Combine)
import Foundation
import Combine
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

#if canImport(FirebaseAuth)

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

final class AuthManager: ObservableObject {
    struct User {
        let uid: String
        let email: String?
    }

    static let shared = AuthManager()

    @Published private(set) var currentUser: User?

    private init() {}

    func signUp(email: String,
                password: String,
                displayName: String? = nil,
                completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, dob: Date, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, code: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        completion(AuthError.unavailable)
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String) async throws -> User {
        throw AuthError.unavailable
    }

    @available(iOS 15.0, *)
    func signUp(email: String,
                password: String,
                displayName: String? = nil) async throws -> User {
        throw AuthError.unavailable
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String, dob: Date) async throws -> User {
        throw AuthError.unavailable
    }

    @available(iOS 15.0, *)
    func signIn(email: String, password: String, code: String) async throws -> User {
        throw AuthError.unavailable
    }

    func signInAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    @available(iOS 15.0, *)
    func signInAnonymously() async throws -> User {
        throw AuthError.unavailable
    }

    func signOut() throws {
        throw AuthError.unavailable
    }

enum AuthError: Error {
        case unavailable
    }
}

#endif

#else

import Foundation
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

final class AuthManager {
    struct User {
        let uid: String
        let email: String?
    }

    static let shared = AuthManager()

    private(set) var currentUser: User?

    private init() {}

    func signUp(email: String,
                password: String,
                displayName: String? = nil,
                completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, dob: Date, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signIn(email: String, password: String, code: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        completion(AuthError.unavailable)
    }

    func signInAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        completion(.failure(AuthError.unavailable))
    }

    func signOut() throws {
        throw AuthError.unavailable
    }

    enum AuthError: Error {
        case unavailable
    }
}

#endif
