#if canImport(SwiftUI)
import SwiftUI

/// Provides global colors and gradients for CoreForge apps.
public enum AppTheme {
    /// Primary gradient used across backgrounds.
    public static var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [Color.accentColor, Color.accentColor.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Accent color used for icons and interactive elements.
    public static var accentColor: Color {
        Color.accentColor
    }

    /// Material for cards and popups.
    public static var cardMaterial: Material { .regularMaterial }

    /// Standard corner radius for cards.
    public static var cornerRadius: CGFloat { 8 }

    /// Standard shadow radius for cards.
    public static var shadowRadius: CGFloat { 2 }
}
#endif

