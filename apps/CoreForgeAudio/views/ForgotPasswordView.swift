#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Password reset via email.
struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var message: String?
    var onComplete: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("Reset Password")
                .font(.title)
                .foregroundColor(AppTheme.foregroundColor)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            if let message = message {
                Text(message)
                    .font(.caption)
                    .foregroundColor(.green)
            }
            Button("Send Reset") { reset() }
                .font(.headline)
                .buttonStyle(GlowingButtonStyle())
            Spacer()
        }
        .padding()
        .background(AppTheme.primaryGradient.ignoresSafeArea())
    }

    private func reset() {
        AuthManager.shared.resetPassword(email: email) { error in
            if let error = error {
                message = error.localizedDescription
            } else {
                message = "Email sent"
                onComplete()
            }
        }
    }
}

#Preview {
    ForgotPasswordView(onComplete: {})
}
#endif
