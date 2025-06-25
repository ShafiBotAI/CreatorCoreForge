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

struct MainTabView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        TabView {
            DashboardView()
                .environmentObject(usage)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }
            LibraryView()
                .environmentObject(library)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            ConnectView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Connect", systemImage: "link")
                }
            ImportView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Import", systemImage: "square.and.arrow.down")
                }
            PlayerView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Player", systemImage: "play.circle")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            SettingsView()
                .environmentObject(usage)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
#endif
