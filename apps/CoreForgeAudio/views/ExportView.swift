#if canImport(SwiftUI)
import SwiftUI

/// Simple export button that consumes credits via `ExportManager`.
struct ExportView: View {
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Button("Export Project") {
                if ExportManager.export() {
                    message = "Export started"
                } else {
                    message = "Not enough credits"
                }
            }
            Text(message)
                .font(.caption)
        }
        .padding()
    }
}

#Preview { ExportView() }
#endif
