#if canImport(SwiftUI)
import SwiftUI

/// Light/dark mode toggle for theme.
struct DarkModeSwitcherView: View {
    @Environment(\.colorScheme) var scheme
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        Toggle("Dark Mode", isOn: $darkMode)
            .onChange(of: darkMode) { value in
#if canImport(AppKit)
                NSApp.appearance = value ? NSAppearance(named: .darkAqua) : NSAppearance(named: .aqua)
#endif
            }
    }
}

#Preview {
    DarkModeSwitcherView()
}
#endif
