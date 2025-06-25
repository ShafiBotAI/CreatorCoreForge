import Foundation
#if canImport(SwiftUI)
import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    var onSignUp: ((String, String) -> Void)?

    var body: some View {
        Form {
            Section(header: Text("Sign Up")) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirm)
            }
            Button("Create Account") {
                guard password == confirm else { return }
                onSignUp?(email, password)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
