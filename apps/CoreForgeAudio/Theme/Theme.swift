#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Local convenience helpers for CoreForge Audio styling.
public enum Theme {
    public static var cardMaterial: Material { AppTheme.cardMaterial }
    public static var cornerRadius: CGFloat { AppTheme.cornerRadius }
    public static var shadowRadius: CGFloat { AppTheme.shadowRadius }
}
#endif
