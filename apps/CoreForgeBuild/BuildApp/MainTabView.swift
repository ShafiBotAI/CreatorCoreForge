#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Main tabbed navigation view for CoreForge Build.
struct MainTabView: View {
    enum Tab: Int, CaseIterable { case dashboard, newApp, designer, status }

    @State private var selection: Tab = .dashboard

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: { selection = tab }) {
                        VStack {
                            Image(systemName: icon(for: tab))
                                .foregroundColor(AppTheme.foregroundColor)
                            Text(title(for: tab))
                                .font(.caption2)
                                .foregroundColor(AppTheme.foregroundColor.opacity(selection == tab ? 1 : 0.7))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical, 8)
            .background(AppTheme.primaryGradient)

            TabView(selection: $selection) {
                AppDashboardView()
                    .tag(Tab.dashboard)
                NewAppFromPromptView()
                    .tag(Tab.newApp)
                UIDesignerCanvasView()
                    .tag(Tab.designer)
                BuildPipelineStatusView()
                    .tag(Tab.status)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    private func icon(for tab: Tab) -> String {
        switch tab {
        case .dashboard: return "gauge"
        case .newApp: return "plus.app"
        case .designer: return "paintbrush"
        case .status: return "wrench.and.screwdriver"
        }
    }

    private func title(for tab: Tab) -> String {
        switch tab {
        case .dashboard: return "Dashboard"
        case .newApp: return "New App"
        case .designer: return "Designer"
        case .status: return "Status"
        }
    }
}
#endif
