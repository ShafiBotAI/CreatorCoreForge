#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var library = LibraryModel()

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainTabView()
                    .environmentObject(library)
                    .transition(.opacity)
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
    }
}

struct MainTabView: View {
    @EnvironmentObject var library: LibraryModel

    var body: some View {
        TabView {
            LibraryView()
                .environmentObject(library)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            ImportView()
                .environmentObject(library)
                .tabItem {
                    Label("Import", systemImage: "square.and.arrow.down")
                }
            PlayerView()
                .environmentObject(library)
                .tabItem {
                    Label("Player", systemImage: "play.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
#endif
