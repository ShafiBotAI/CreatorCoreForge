#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Registration screen with tier selection.
struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var selectedTier: SubscriptionManager.Plan = .free
    @State private var error: String?
    var onComplete: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("Create Account")
                .font(.title)
                .foregroundColor(AppTheme.foregroundColor)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Picker("Tier", selection: $selectedTier) {
                Text("Free").tag(SubscriptionManager.Plan.free)
                Text("Creator").tag(SubscriptionManager.Plan.creator)
                Text("Author").tag(SubscriptionManager.Plan.author)
                Text("Enterprise").tag(SubscriptionManager.Plan.enterprise)
            }
            .pickerStyle(.segmented)
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            Button("Register") { register() }
                .font(.headline)
                .buttonStyle(GlowingButtonStyle())
            Spacer()
        }
        .padding()
        .background(AppTheme.primaryGradient.ignoresSafeArea())
    }

    private func register() {
        AuthManager.shared.signUp(email: email, password: password, plan: selectedTier) { result in
            switch result {
            case .success:
                SubscriptionManager().upgrade(to: selectedTier)
                onComplete()
            case .failure(let err):
                error = err.localizedDescription
            }
        }
    }
}

#Preview {
    RegisterView(onComplete: {})
}
#endif
