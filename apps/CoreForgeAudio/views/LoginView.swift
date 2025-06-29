#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Login screen with email and password fields.
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var error: String?
    var onRegister: () -> Void
    var onForgot: () -> Void
    var onSuccess: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("CoreForge Audio")
                .font(.title)
                .foregroundColor(AppTheme.foregroundColor)
                .transition(.scale)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            Button("Sign In") { login() }
                .font(.headline)
                .buttonStyle(GlowingButtonStyle())
            Button("Sign In with Google") {
                AuthManager.shared.signInWithGoogle(email: "google@example.com") { _ in
                    onSuccess()
                }
            }
            .font(.caption)
            Button("Sign In with Apple") {
                AuthManager.shared.signInWithApple(email: "apple@example.com") { _ in
                    onSuccess()
                }
            }
            .font(.caption)
            Button("Forgot Password?", action: onForgot)
                .font(.caption)
            Button("Register") { onRegister() }
                .font(.caption)
            Button("Continue as Guest") {
                AuthManager.shared.signInAnonymously {
                    onSuccess()
                }
            }
            .font(.caption)
            Spacer()
        }
        .padding()
        .background(AppTheme.primaryGradient.ignoresSafeArea())
    }

    private func login() {
        AuthManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                onSuccess()
            case .failure(let err):
                error = err.localizedDescription
            }
        }
    }
}

#Preview {
    LoginView(onRegister: {}, onForgot: {}, onSuccess: {})
}
#endif
