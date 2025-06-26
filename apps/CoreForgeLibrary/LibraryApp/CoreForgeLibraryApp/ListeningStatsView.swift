#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays basic listening progress and streaks.
struct ListeningStatsView: View {
    var hoursThisWeek: Double
    var dailyStreak: Int
    var booksFinished: Int
    var chaptersPlayed: Int

    var body: some View {
        Group {
            if hoursThisWeek == 0 && dailyStreak == 0 && booksFinished == 0 && chaptersPlayed == 0 {
                EmptyStateView(systemImage: "chart.bar", message: "No listening data yet")
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Hours this week")
                        Spacer()
                        Text(String(format: "%.1f", hoursThisWeek))
                    }
                    HStack {
                        Text("Daily streak")
                        Spacer()
                        Text("\(dailyStreak) days")
                    }
                    HStack {
                        Text("Books finished")
                        Spacer()
                        Text("\(booksFinished)")
                    }
                    HStack {
                        Text("Chapters played")
                        Spacer()
                        Text("\(chaptersPlayed)")
                    }
                }
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}
#endif

