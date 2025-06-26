#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Shows current subscription tier and export credits.
struct SubscriptionStatusCard: View {
    var tier: String

    var body: some View {
        Theme.card {
            HStack {
                VStack(alignment: .leading) {
                    Text("Subscription")
                        .font(.headline)
                    Text(tier)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SubscriptionStatusCard(tier: "Free")
}
#endif
