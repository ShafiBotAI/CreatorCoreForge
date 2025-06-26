#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Central entry point for daily usage showing goals and quick actions.
struct HomeDashboardView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    @AppStorage("dailyGoal") private var dailyGoal: Int = 30

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    DailyGoalCard(goalMinutes: dailyGoal, progress: Int(usage.totalListeningTime/60))
                    QuickStartList(books: Array(library.books.prefix(3)))
                    ImportShortcutsPanel()
                    TodayHighlightsCarousel(books: library.books)
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
