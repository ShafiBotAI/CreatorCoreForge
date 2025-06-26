#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var library = LibraryModel()
    @StateObject private var usage = UsageStats()
    @Namespace private var ns
    @State private var selectedTab = 0

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainTabView(namespace: ns, selection: $selectedTab)
                    .environmentObject(library)
                    .environmentObject(usage)
                    .transition(.scale)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding, namespace: ns)
                    .transition(.scale)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
#endif
