#if canImport(SwiftUI)
import SwiftUI

/// Displays basic listening progress and streaks.
struct ListeningStatsView: View {
    var hoursThisWeek: Double
    var dailyStreak: Int
    var booksFinished: Int
    var chaptersPlayed: Int
    var streakGoal: Int = 7

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
                        if dailyStreak < streakGoal {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                        } else if dailyStreak >= streakGoal {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
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

#Preview {
    ListeningStatsView(hoursThisWeek: 5, dailyStreak: 3, booksFinished: 2, chaptersPlayed: 10)
}
#endif
