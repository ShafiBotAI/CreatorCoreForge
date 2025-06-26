#if canImport(SwiftUI)
import SwiftUI

/// Displays basic listening progress and streaks.
struct ListeningStatsView: View {
    var hoursThisWeek: Double
    var dailyStreak: Int
    var booksFinished: Int
    var chaptersPlayed: Int

    var body: some View {
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
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}
#endif
