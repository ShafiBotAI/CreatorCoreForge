import Foundation

/// Styles a line of dialogue with NSFW tone hints.
public enum NSFWStyle: String, Codable, CaseIterable {
    case soft
    case sensual
    case dominant
    case whisper
    case aggressive
    case vulnerable
}

/// Output of an NSFW tone styling request.
public struct StyledVoiceOutput: Codable, Equatable {
    public let styledText: String
    public let style: NSFWStyle
    public init(text: String, style: NSFWStyle) {
        self.styledText = text
        self.style = style
    }
}

/// Apply a tone style to the provided sentence.
/// The function prepends a short tag matching the style.
public func applyNSFWTone(to sentence: String, context: NSFWStyle) -> StyledVoiceOutput {
    let prefix: String
    switch context {
    case .soft:
        prefix = "[Soft]"
    case .sensual:
        prefix = "[Sensual]"
    case .dominant:
        prefix = "[Dominant]"
    case .whisper:
        prefix = "[Whisper]"
    case .aggressive:
        prefix = "[Aggressive]"
    case .vulnerable:
        prefix = "[Vulnerable]"
    }
    return StyledVoiceOutput(text: "\(prefix) \(sentence)", style: context)
}
