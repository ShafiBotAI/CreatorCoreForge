import Foundation
#if canImport(SwiftUI)
import SwiftUI


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var onLogin: ((String, String) -> Void)?

    var body: some View {
        Form {
            Section(header: Text("Login")) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
            }
            Button("Login") {
                onLogin?(email, password)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
