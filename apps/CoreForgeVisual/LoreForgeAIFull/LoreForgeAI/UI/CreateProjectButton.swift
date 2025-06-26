import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct CreateProjectButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle")
                .font(.largeTitle)
        }
        .accessibilityLabel("Create Project")
    }
}
#else
struct CreateProjectButton {
    var action: () -> Void
    func tap() { action() }
}
#endif
