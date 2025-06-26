import SwiftUI
import CreatorCoreForge

struct AppDashboardView: View {
    @State private var usedBuilds: Int = 3
    @State private var totalQuota: Int = 10

    var body: some View {
        VStack(spacing: 16) {
            BuildQuotaMeterView(used: usedBuilds, quota: totalQuota)
            Text("App Dashboard")
        }
        .padding()
    }
}

#Preview {
    AppDashboardView()
}
