#if canImport(SwiftUI)
import SwiftUI

struct EmptyStateView: View {
    var systemImage: String
    var message: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.secondary)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(systemImage: "books.vertical", message: "No Items")
}
#endif
