#if canImport(SwiftUI)
import SwiftUI

/// Display the user's referral code and share link.
struct ReferralView: View {
    @ObservedObject var manager = ReferralManager.shared

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Share your referral code")
                    .font(.headline)
                Text(manager.myCode())
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .padding()
                if let url = URL(string: "https://example.com/ref/\(manager.myCode())") {
                    ShareLink(item: url) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
                Spacer()
            }
            .navigationTitle("Referral")
            .padding()
        }
    }
}

#Preview {
    ReferralView()
}
#endif
