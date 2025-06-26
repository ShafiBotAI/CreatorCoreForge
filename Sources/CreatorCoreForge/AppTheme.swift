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
}
#endif

