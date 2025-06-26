#if canImport(SwiftUI)
import SwiftUI

/// Displays usage metrics, subscription status, and achievements.
struct DashboardView: View {
    @EnvironmentObject var usage: UsageStats
    @Binding var tabSelection: Int

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Usage")) {
                    HStack {
                        Text("Listening Time")
                        Spacer()
                        Text(timeString(usage.totalListeningTime))
                    }
                    HStack {
                        Text("Imported Books")
                        Spacer()
                        Text("\(usage.importedBooks)")
                    }
                }

                Section(header: Text("Subscription")) {
                    HStack {
                        Text("Tier")
                        Spacer()
                        Text(usage.subscriptionTier)
                    }
                    HStack {
                        Text("Credits Used")
                        Spacer()
                        Text("\(usage.creditsUsed)")
                    }
                }

                if !usage.achievements.isEmpty {
                    Section(header: Text("Achievements")) {
                        ForEach(usage.achievements, id: \.self) { ach in
                            Text(ach)
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                Menu {
                    Button("Library") { tabSelection = 1 }
                    Button("Connect") { tabSelection = 2 }
                    Button("Import") { tabSelection = 3 }
                    Button("Player") { tabSelection = 4 }
                    Button("Favorites") { tabSelection = 5 }
                    Button("Settings") { tabSelection = 6 }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }

    private func timeString(_ time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time.truncatingRemainder(dividingBy: 3600)) / 60
        return "\(h)h \(m)m"
    }
}
#endif
