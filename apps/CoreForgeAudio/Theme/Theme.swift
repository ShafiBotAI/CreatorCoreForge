#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Local convenience helpers for CoreForge Audio styling.
public enum Theme {
    public static var primaryGradient: LinearGradient { AppTheme.primaryGradient }
    public static var accentColor: Color { AppTheme.accentColor }
    public static var cardMaterial: Material { AppTheme.cardMaterial }
    public static var cornerRadius: CGFloat { AppTheme.cornerRadius }
    public static var shadowRadius: CGFloat { AppTheme.shadowRadius }

    /// Applies standard card styling to content.
    public static func card<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        content()
            .padding()
            .background(cardMaterial)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }
}
#endif
