#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var onboarding = OnboardingManager()
    @StateObject private var library = LibraryModel()
    @StateObject private var usage = UsageStats()
    @Namespace private var ns
    @State private var selectedTab = 0

    var body: some View {
        Group {
            if hasSeenOnboarding || onboarding.isCompleted(.finished) {
                MainTabView(namespace: ns, selection: $selectedTab)
                    .environmentObject(library)
                    .environmentObject(usage)
                    .environmentObject(onboarding)
                    .transition(.scale)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding, namespace: ns)
                    .environmentObject(onboarding)
                    .transition(.scale)
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
#endif
