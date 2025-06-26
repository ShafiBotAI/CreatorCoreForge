#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Dialog shown if NSFW add-on is not active.
struct NSFWUnlockModal: View {
    var upgradeAction: () -> Void
    var cancelAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("NSFW Content Locked")
                .font(.headline)
            Text("Upgrade your plan to access NSFW features.")
                .multilineTextAlignment(.center)
            HStack {
                Button("Not Now", action: cancelAction)
                    .buttonStyle(.bordered)
                Button("Upgrade", action: upgradeAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
        .shadow(radius: Theme.shadowRadius)
    }
}

#Preview {
    NSFWUnlockModal(upgradeAction: {}, cancelAction: {})
}
#endif
