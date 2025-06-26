#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Top tabbed interface matching CoreForge branding.
struct MainTabView: View {
    enum Tab: Int, CaseIterable { case home, library, ai, settings }

    @State private var selection: Tab = .home
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
            .background(AppTheme.primaryGradient)

            TabView(selection: $selection) {
                HomeDashboardView()
                    .environmentObject(library)
                    .environmentObject(usage)
                    .tag(Tab.home)
                LibraryView()
                    .environmentObject(library)
                    .tag(Tab.library)
                AIExploreView()
                    .tag(Tab.ai)
                SettingsProfileView()
                    .environmentObject(usage)
                    .tag(Tab.settings)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    private func icon(for tab: Tab) -> String {
        switch tab {
        case .home: return "house.fill"
        case .library: return "books.vertical.fill"
        case .ai: return "sparkles"
        case .settings: return "gearshape.fill"
        }
    }

    private func title(for tab: Tab) -> String {
        switch tab {
        case .home: return "Home"
        case .library: return "Library"
        case .ai: return "AI"
        case .settings: return "Settings"
        }
    }
}
#endif
