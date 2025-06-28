import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

enum SubscriptionTier: String, CaseIterable {
    case free
    case creator
    case enterprise
    case author
}

#if canImport(SwiftUI)
struct SubscriptionPlanSelector: View {
    @Binding var tier: SubscriptionTier

    private var nsfwInfo: String {
        switch tier {
        case .free, .creator:
            return "NSFW Mode requires Add-On"
        case .enterprise, .author:
            return "NSFW Mode Included"
        }
    }

    var body: some View {
        Picker("Plan", selection: $tier) {
            ForEach(SubscriptionTier.allCases, id: \.self) { plan in
                Text(plan.rawValue.capitalized).tag(plan)
            }
        }
        .pickerStyle(.segmented)
        Text(nsfwInfo)
            .font(.caption)
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
