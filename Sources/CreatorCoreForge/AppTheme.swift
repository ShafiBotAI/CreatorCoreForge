#if canImport(SwiftUI)
import SwiftUI

/// Provides global colors and gradients for CoreForge apps.
public enum AppTheme {
    /// Primary gradient used across backgrounds.
    public static var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [Color.purple, Color.blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Accent color used for icons and interactive elements.
    public static var accentColor: Color {
        Color.purple
    }

    /// Material for cards and popups.
    public static var cardMaterial: Material { .ultraThinMaterial }

    /// Standard corner radius for cards.
    public static var cornerRadius: CGFloat { 12 }

    /// Standard shadow radius for cards.
    public static var shadowRadius: CGFloat { 4 }

    /// Foreground color that adapts to light/dark mode.
    public static var foregroundColor: Color {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        return Color(.label)
        #else
        return Color.primary
        #endif
    }

    /// Secondary text color that adapts to light/dark mode.
    public static var secondaryColor: Color {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        return Color(.secondaryLabel)
        #else
        return Color.secondary
        #endif
    }
}
#endif

