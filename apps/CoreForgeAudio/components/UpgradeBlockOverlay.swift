#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Semi-transparent overlay blocking access to premium features.
struct UpgradeBlockOverlay: View {
    var upgradeAction: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Feature Locked")
                    .font(.headline)
                    .foregroundColor(.white)
                Button("Upgrade to Unlock", action: upgradeAction)
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(Theme.cardMaterial)
            .cornerRadius(Theme.cornerRadius)
            .shadow(radius: Theme.shadowRadius)
        }
    }
}

#Preview {
    UpgradeBlockOverlay(upgradeAction: {})
}
#endif
