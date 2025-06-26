#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var library = LibraryModel()
    @StateObject private var usage = UsageStats()

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainTabView()
                    .environmentObject(library)
                    .environmentObject(usage)
                    .transition(.opacity)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
}

#endif
