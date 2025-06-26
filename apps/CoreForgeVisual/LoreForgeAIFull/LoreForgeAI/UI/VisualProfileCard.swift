import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

enum VisualTier: String, CaseIterable {
    case free
    case creator
    case enterprise
}

#if canImport(SwiftUI)
struct VisualProfileCard: View {
    var name: String
    var tier: VisualTier
    var avatar: Image = Image(systemName: "person.crop.circle")

    var body: some View {
        VStack(spacing: 12) {
            avatar
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Text(name)
                .font(.headline)
            Text(tier.rawValue.capitalized)
                .font(.caption)
                .padding(4)
                .background(Capsule().fill(Color.accentColor.opacity(0.2)))
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VisualProfileCard(name: "Creator", tier: .creator)
}
#endif
