#if canImport(SwiftUI)
import SwiftUI

/// Wrapper view mapping MainDashboardView to existing HomeDashboardView.
struct MainDashboardView: View {
    var body: some View {
        HomeDashboardView()
    }
}

#Preview {
    MainDashboardView()
}
#endif
