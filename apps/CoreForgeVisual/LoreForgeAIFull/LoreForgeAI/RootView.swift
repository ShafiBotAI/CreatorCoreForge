import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct RootView: View {
    @AppStorage("visualHasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var selection = 0

    var body: some View {
        Group {
            if hasSeenOnboarding {
                mainTabs
            } else {
                VisualOnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }

    private var mainTabs: some View {
        TabView(selection: $selection) {
            VisualDashboardView()
                .tabItem { Label("Dashboard", systemImage: "rectangle.stack") }
                .tag(0)
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(1)
        }
    }
}

#Preview { RootView() }
#endif
