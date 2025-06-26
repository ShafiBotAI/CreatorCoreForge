#if canImport(SwiftUI)
import SwiftUI

/// Generic empty state placeholder with branded illustration.
public struct EmptyStateView: View {
    public var systemImage: String
    public var message: String

    public init(systemImage: String, message: String) {
        self.systemImage = systemImage
        self.message = message
    }

    public var body: some View {
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
    EmptyStateView(systemImage: "books.vertical", message: "Nothing here yet")
}
#endif
