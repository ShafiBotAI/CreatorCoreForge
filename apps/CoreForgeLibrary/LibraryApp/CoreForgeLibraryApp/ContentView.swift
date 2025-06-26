import Foundation
#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge
struct ContentView: View {
    @State private var loggedInUser: String?
    @State private var showSignUp = false
    @StateObject private var usage = UsageStats()

    var body: some View {
        NavigationView {
            if let _ = loggedInUser {
                MainTabView()
                    .environmentObject(usage)
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

struct MainTabView: View {
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        DashboardTabView(tabs: [
            DashboardTab(title: "Dashboard", systemImage: "chart.bar") {
                DashboardView().environmentObject(usage)
            },
            DashboardTab(title: "Library", systemImage: "books.vertical") {
                LibraryView()
            }
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
