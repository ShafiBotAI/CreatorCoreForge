import Foundation

/// Manages the Multiverse Director mode for alternate render styles.
public final class MultiverseDirectorToggle {
    public private(set) var isEnabled: Bool
    public private(set) var currentStyle: String?
    public let availableStyles: [String]

    public init(enabled: Bool = false, styles: [String] = ["Anime", "Noir", "Fantasy"]) {
        self.isEnabled = enabled
        self.availableStyles = styles
    }

    /// Enable or disable the director mode.
    public func toggle() { isEnabled.toggle() }

    /// Select a style when director mode is enabled.
    @discardableResult
    public func selectStyle(_ style: String) -> Bool {
        guard availableStyles.contains(style) else { return false }
        currentStyle = style
        return true
    }
}
