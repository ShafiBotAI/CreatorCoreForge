#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// In-app tier selection modal.
struct TierUpgradeView: View {
    @Binding var isPresented: Bool
    @State private var selected: SubscriptionManager.Plan = .creator
    var onUpgrade: (SubscriptionManager.Plan) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Picker("Plan", selection: $selected) {
                Text("Creator").tag(SubscriptionManager.Plan.creator)
                Text("Enterprise").tag(SubscriptionManager.Plan.enterprise)
            }
            .pickerStyle(.segmented)
            Button("Upgrade") {
                onUpgrade(selected)
                isPresented = false
            }
            .buttonStyle(GlowingButtonStyle())
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
        .shadow(radius: Theme.shadowRadius)
    }
}

#Preview {
    TierUpgradeView(isPresented: .constant(true)) { _ in }
        .padding()
        .background(Color.gray)
}
#endif
