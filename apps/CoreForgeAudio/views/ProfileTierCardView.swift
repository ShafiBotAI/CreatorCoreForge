#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays user avatar and subscription tier with upgrade button.
struct ProfileTierCardView: View {
    var userName: String
    var tier: String
    var upgradeAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(AppTheme.primaryGradient)
                    .frame(width: 50, height: 50)
                    .overlay(Text(String(userName.prefix(1))).foregroundColor(.white))
                VStack(alignment: .leading) {
                    Text(userName)
                    Text(tier).font(.caption).foregroundColor(.secondary)
                }
                Spacer()
                Button("Upgrade Plan", action: upgradeAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}
#endif
