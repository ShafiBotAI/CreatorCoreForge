import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

enum SubscriptionTier: String, CaseIterable {
    case free
    case creator
    case enterprise
}

#if canImport(SwiftUI)
struct SubscriptionPlanSelector: View {
    @Binding var tier: SubscriptionTier

    var body: some View {
        Picker("Plan", selection: $tier) {
            ForEach(SubscriptionTier.allCases, id: \.self) { plan in
                Text(plan.rawValue.capitalized).tag(plan)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    StatefulPreview()
}

private struct StatefulPreview: View {
    @State private var tier: SubscriptionTier = .free
    var body: some View {
        SubscriptionPlanSelector(tier: $tier)
            .padding()
    }
}
#endif
