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
}


=======

=======
struct MainTabView: View {
    var namespace: Namespace.ID
    @Binding var selection: Int
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        TabView(selection: $selection) {
            DashboardView(tabSelection: $selection)
                .environmentObject(usage)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }
                .tag(0)
            LibraryView(namespace: namespace)
                .environmentObject(library)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
                .tag(1)
            ConnectView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Connect", systemImage: "link")
                }
                .tag(2)
            ImportView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Import", systemImage: "square.and.arrow.down")
                }
                .tag(3)
            PlayerView()
                .environmentObject(library)
                .environmentObject(usage)
                .tabItem {
                    Label("Player", systemImage: "play.circle")
                }
                .tag(4)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(5)
            SettingsView()
                .environmentObject(usage)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(6)
        }
    }
}


#endif
