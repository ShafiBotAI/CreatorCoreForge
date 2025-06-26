import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct VisualDashboardView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("CoreForge Visual")
                    .font(.largeTitle)
                RecentProjectsCarousel()
            }
            .navigationTitle("Dashboard")
        }
    }
}
#else
struct VisualDashboardView {}
#endif
