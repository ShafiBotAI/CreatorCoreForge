#if canImport(SwiftUI)
import SwiftUI

/// Enable or disable continuous auto-scroll.
struct AutoScrollToggleView: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle("Auto Scroll", isOn: $isOn)
    }
}

#Preview {
    AutoScrollToggleView(isOn: .constant(true))
}
#endif
