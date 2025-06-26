#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays basic usage statistics.
struct DashboardView: View {
    @EnvironmentObject var usage: UsageStats

    private func timeString(_ time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time.truncatingRemainder(dividingBy: 3600)) / 60
        return "\(h)h \(m)m"
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Activity")) {
                    HStack {
                        Text("Books Read")
                        Spacer()
                        Text("\(usage.booksRead)")
                    }
                    HStack {
                        Text("Listening Time")
                        Spacer()
                        Text(timeString(usage.hoursListened))
                    }
                    HStack {
                        Text("Favorites")
                        Spacer()
                        Text("\(usage.favorites)")
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}
#endif
