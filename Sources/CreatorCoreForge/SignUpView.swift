#if canImport(SwiftUI)
import SwiftUI

/// Basic sign up form requesting email, password, and date of birth.
/// On submit, the user is automatically signed in via `BasicAuthService`.
public struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var dob = Date()
    @State private var signedIn = false

    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
            Button("Register") {
                BasicAuthService.shared.register(email: email, password: password, dob: dob)
                signedIn = BasicAuthService.shared.signIn(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            if signedIn {
                Text("Signed in as \(email)")
            }
        }
        .padding()
    }
}
#endif
