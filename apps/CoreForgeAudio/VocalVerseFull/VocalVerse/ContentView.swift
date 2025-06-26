#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var onboarding = OnboardingManager()
    @StateObject private var library = LibraryModel()
    @StateObject private var usage = UsageStats()
    @StateObject private var prefs = UserPreferences.shared
    @StateObject private var offlineManager: OfflineContentManager
        
    init() {
        let lib = LibraryModel()
        _offlineManager = StateObject(wrappedValue: OfflineContentManager(library: lib))
        _library = StateObject(wrappedValue: lib)
    }
    @Namespace private var ns
    @State private var selectedTab = 0

    var body: some View {
        Group {
            if hasSeenOnboarding || onboarding.isCompleted(.finished) {
                MainTabView(namespace: ns, selection: $selectedTab)
                    .environmentObject(library)
                    .environmentObject(usage)
                    .environmentObject(onboarding)
                    .environmentObject(prefs)
                    .environmentObject(offlineManager)
                    .transition(.scale)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding, namespace: ns)
                    .environmentObject(onboarding)
                    .environmentObject(prefs)
                    .transition(.scale)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
}

#Preview {
    ContentView()
        .environmentObject(UserPreferences.shared)
}
#endif
