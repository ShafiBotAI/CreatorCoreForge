import Foundation
#if canImport(SwiftUI)
import SwiftUI
struct ContentView: View {
    @State private var loggedInUser: String?
    @State private var showSignUp = false

    var body: some View {
        NavigationView {
            if let user = loggedInUser {
                LibraryView(userID: user)
                    .navigationTitle("Library")
            } else if showSignUp {
                SignUpView { email, password in
                    // Mock auth success
                    loggedInUser = email
                }
                .navigationTitle("Sign Up")
                .toolbar { Button("Login") { showSignUp = false } }
            } else {
                LoginView { email, password in
                    // Mock auth success
                    loggedInUser = email
                }
                .navigationTitle("Login")
                .toolbar { Button("Sign Up") { showSignUp = true } }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
