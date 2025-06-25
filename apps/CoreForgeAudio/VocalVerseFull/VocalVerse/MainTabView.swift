#if canImport(SwiftUI)
import SwiftUI

/// Top tabbed interface matching CoreForge branding.
struct MainTabView: View {
    enum Tab: Int, CaseIterable { case dashboard, library, connect, importBook, player, settings }

    @State private var selection: Tab = .dashboard
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: { selection = tab }) {
                        VStack {
                            Image(systemName: icon(for: tab))
                                .foregroundColor(.white)
                                .shadow(color: .white, radius: selection == tab ? 4 : 0)
                            Text(title(for: tab))
                                .font(.caption2)
                                .foregroundColor(.white.opacity(selection == tab ? 1 : 0.7))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical, 8)
            .background(
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
            )

            TabView(selection: $selection) {
                DashboardView()
                    .environmentObject(usage)
                    .tag(Tab.dashboard)
                LibraryView()
                    .environmentObject(library)
                    .tag(Tab.library)
                ConnectView()
                    .environmentObject(library)
                    .environmentObject(usage)
                    .tag(Tab.connect)
                ImportView()
                    .environmentObject(library)
                    .environmentObject(usage)
                    .tag(Tab.importBook)
                PlayerView()
                    .environmentObject(library)
                    .environmentObject(usage)
                    .tag(Tab.player)
                SettingsView()
                    .environmentObject(usage)
                    .tag(Tab.settings)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    private func icon(for tab: Tab) -> String {
        switch tab {
        case .dashboard: return "chart.bar.fill"
        case .library: return "books.vertical.fill"
        case .connect: return "link"
        case .importBook: return "square.and.arrow.down"
        case .player: return "play.circle.fill"
        case .settings: return "gearshape.fill"
        }
    }

    private func title(for tab: Tab) -> String {
        switch tab {
        case .dashboard: return "Dashboard"
        case .library: return "Library"
        case .connect: return "Connect"
        case .importBook: return "Import"
        case .player: return "Player"
        case .settings: return "Settings"
        }
    }
}
#endif
