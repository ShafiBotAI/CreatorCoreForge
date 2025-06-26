#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Shows listening streak and today's time goal.
struct DailyGoalCard: View {
    var goalMinutes: Int
    var progress: Int

    var body: some View {
        Theme.card {
            HStack {
                VStack(alignment: .leading) {
                    Text("Daily Goal")
                        .font(.headline)
                    Text("\(progress)/\(goalMinutes) min")
                        .font(.title)
                        .bold()
                }
                Spacer()
                Image(systemName: progress >= goalMinutes ? "checkmark.circle" : "clock")
                    .foregroundColor(.accentColor)
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    DailyGoalCard(goalMinutes: 30, progress: 10)
}
#endif
