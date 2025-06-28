#if canImport(SwiftUI)
import SwiftUI

/// Displays pricing for all subscription tiers with monthly/annual toggle.
struct PricingView: View {
    @State private var cycle: SubscriptionManager.BillingCycle = .monthly
    @ObservedObject private var manager = SubscriptionManager.shared

    var body: some View {
        VStack {
            Picker("Billing", selection: $cycle) {
                ForEach(SubscriptionManager.BillingCycle.allCases, id: \.self) { cycle in
                    Text(cycle.displayName).tag(cycle)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            List {
                ForEach(SubscriptionManager.Plan.allCases, id: \.self) { plan in
                    pricingRow(for: plan)
                }
            }
        }
    }

    private func pricingRow(for plan: SubscriptionManager.Plan) -> some View {
        let price = manager.price(for: plan, cycle: cycle)
        let credits = manager.credits(for: plan)
        let monthly = manager.price(for: plan, cycle: .monthly)
        let savings = cycle == .annual ? monthly * 12 - price : 0
        return HStack {
            VStack(alignment: .leading) {
                Text(plan.displayName).font(.headline)
                Text("\(credits) credits").font(.caption)
                if savings > 0 {
                    Text(String(format: "Save $%.0f", savings))
                        .font(.caption2)
                        .foregroundStyle(.green)
                }
            }
            Spacer()
            Text(String(format: "$%.2f", price))
                .bold()
        }
    }
}

#Preview {
    PricingView()
}
#endif
