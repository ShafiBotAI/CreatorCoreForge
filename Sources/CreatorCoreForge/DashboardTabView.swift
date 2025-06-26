#if canImport(SwiftUI)
import SwiftUI

/// Represents a single tab configuration for DashboardTabView.
public struct DashboardTab {
    public var title: String
    public var systemImage: String
    public var view: AnyView

    public init<Content: View>(title: String, systemImage: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.view = AnyView(content())
    }
}

/// Shared TabView styled with the CoreForge Audio theme.
public struct DashboardTabView: View {
    private var tabs: [DashboardTab]

    public init(tabs: [DashboardTab]) {
        self.tabs = tabs
    }

    public var body: some View {
        ZStack {
            AppTheme.primaryGradient.ignoresSafeArea()
            TabView {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                    tab.view
                        .tabItem { Label(tab.title, systemImage: tab.systemImage) }
                        .tag(index)
                }
            }
            .accentColor(AppTheme.accentColor)
        }
    }
}
#endif
