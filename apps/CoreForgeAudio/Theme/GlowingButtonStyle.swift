#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Glowing button style matching CoreForge branding.
struct GlowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(AppTheme.primaryGradient)
            .foregroundColor(.white)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: Color.white.opacity(configuration.isPressed ? 0.4 : 0.8), radius: configuration.isPressed ? 4 : 8)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}
#endif
