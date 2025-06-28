#if canImport(SwiftUI)
import SwiftUI

/// Allows upgrading the subscription tier with an annual toggle.
struct TierUpgradeView: View {
    @State private var selectedPlan: SubscriptionManager.Plan = .creator
    @State private var cycle: SubscriptionManager.BillingCycle = .monthly
    @ObservedObject private var manager = SubscriptionManager.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            PricingView()
                .frame(height: 300)
            Picker("Plan", selection: $selectedPlan) {
                ForEach(SubscriptionManager.Plan.allCases, id: \.self) { plan in
                    Text(plan.displayName).tag(plan)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Picker("Billing", selection: $cycle) {
                ForEach(SubscriptionManager.BillingCycle.allCases, id: \.self) { c in
                    Text(c.displayName).tag(c)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Button("Purchase") {
                manager.select(plan: selectedPlan, cycle: cycle)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    TierUpgradeView()
}
#endif
