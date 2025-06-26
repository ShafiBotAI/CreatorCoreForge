#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenBuildOnboarding") private var hasSeenOnboarding = false
    @Namespace private var ns

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainTabView()
                    .transition(.scale)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                    .transition(.scale)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
}
#endif
