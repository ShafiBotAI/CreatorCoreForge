#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Multi-plan selector for upgrading subscriptions.
struct SubscriptionUpgradeView: View {
    @State private var selectedPlan: SubscriptionManager.Plan = .creator
    var upgradeAction: (SubscriptionManager.Plan) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Picker("Plan", selection: $selectedPlan) {
                Text("Creator").tag(SubscriptionManager.Plan.creator)
                Text("Author").tag(SubscriptionManager.Plan.author)
                Text("Enterprise").tag(SubscriptionManager.Plan.enterprise)
            }
            .pickerStyle(.segmented)

            Button("Upgrade") { upgradeAction(selectedPlan) }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
        .shadow(radius: Theme.shadowRadius)
    }
}

#Preview {
    SubscriptionUpgradeView { _ in }
}
#endif
