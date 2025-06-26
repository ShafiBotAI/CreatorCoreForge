import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct ProfileView: View {
    @State private var tier: SubscriptionTier = .free

    var body: some View {
        VStack(spacing: 24) {
            VisualProfileCard(name: "Creator", tier: tier)
            SubscriptionPlanSelector(tier: $tier)
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
#endif
