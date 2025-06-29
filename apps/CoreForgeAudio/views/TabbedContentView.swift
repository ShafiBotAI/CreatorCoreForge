#if canImport(SwiftUI)
import SwiftUI

/// Simplified entry view showcasing core tabs.
struct TabbedContentView: View {
    @Namespace private var ns

    var body: some View {
        TabView {
            MainDashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ImportView()
                .tabItem {
                    Label("Import", systemImage: "tray.and.arrow.down")
                }
            PlayerView(namespace: ns)
                .tabItem {
                    Label("Now Playing", systemImage: "play.circle.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    TabbedContentView()
}
#endif
