#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var library = LibraryModel()
    @StateObject private var usage = UsageStats()
    @Namespace private var ns

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainTabView(namespace: ns)
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
}

struct MainTabView: View {
    var namespace: Namespace.ID
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        TabView {
            DashboardView()
                .environmentObject(usage)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }
            LibraryView(namespace: namespace)
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
