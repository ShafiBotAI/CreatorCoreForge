import Foundation

/// NSFW voice profile with tone, breathing, and cadence settings.
public struct NSFWVoiceProfile {
    public var tone: NSFWStyle
    public var breathing: Double
    public var cadence: Double

    public init(tone: NSFWStyle, breathing: Double = 0.5, cadence: Double = 1.0) {
        self.tone = tone
        self.breathing = breathing
        self.cadence = cadence
    }

    /// Apply the profile to a line of text.
    public func apply(to sentence: String) -> StyledVoiceOutput {
        var output = applyNSFWTone(to: sentence, context: tone)
        output = StyledVoiceOutput(text: "\(output.styledText) [breathing:\(breathing)] [cadence:\(cadence)]", style: tone)
        return output
    }
}

/// Age-gated NSFW rendering mode helper.
public enum NSFWRenderingMode {
    private static var enabled = false

    /// Attempt to enable NSFW mode with age verification.
    @discardableResult
    public static func enable(birthdate: Date, idNumber: String) -> Bool {
        let verifier = AgeIDVerifier()
        guard verifier.verify(birthdate: birthdate, idNumber: idNumber) else { return false }
        enabled = true
        return true
    }

    /// Disable NSFW mode.
    public static func disable() { enabled = false }
    /// Returns whether NSFW mode is active.
    public static var isEnabled: Bool { enabled }
}

/// Per-character NSFW permission settings.
public final class CharacterNSFWPermissions {
    private var permissions: [String: Bool] = [:]
    public init() {}

    public func setPermission(for character: String, allowed: Bool) {
        permissions[character] = allowed
    }

    public func isAllowed(for character: String) -> Bool {
        permissions[character] ?? false
    }
}

/// Tags scenes for NSFW filtering.
public struct NSFWSceneTagger {
    private let keywords: [String]
    public init(keywords: [String] = ["moan", "naked", "touch"]) {
        self.keywords = keywords
    }
    /// Returns true if the scene contains NSFW text.
    public func isNSFW(scene: String) -> Bool {
        let lower = scene.lowercased()
        return keywords.contains { lower.contains($0) }
    }
}

/// Match ambient FX to erotic or horror tones.
public struct NSFWAmbientFXMatcher {
    public func fx(for tone: NSFWStyle) -> [String] {
        switch tone {
        case .sensual, .soft, .whisper:
            return ["bedCreak", "softBreath"]
        case .dominant, .aggressive:
            return ["whip", "chainRattle"]
        default:
            return ["distantEcho"]
        }
    }
}

/// Intensity meter for NSFW performance.
public struct NSFWIntensityMeter {
    public var level: Double
    public init(level: Double = 0.5) {
        self.level = max(0.0, min(1.0, level))
    }

    /// Update the current level using a slider-style value between 0 and 1.
    public mutating func setLevel(_ value: Double) {
        self.level = max(0.0, min(1.0, value))
    }

    /// Map the current level to a discrete intensity used by `NSFWContentManager`.
    public func scaledIntensity() -> NSFWContentManager.NSFWIntensity {
        switch level {
        case ..<0.25: return .off
        case ..<0.5: return .softcore
        case ..<0.75: return .sensual
        case ..<0.9: return .rough
        default: return .hardcore
        }
    }
}

/// Blend text with a sub-tone tag for genre flexibility.
public func blendSubTone(_ text: String, subTone: String) -> String {
    "[\(subTone.capitalized)] " + text
}

/// Apply a whisper-pass filter to enhance intimacy.
public func applyWhisperPass(to text: String) -> String {
    "[WhisperPass] " + text
}

/// Control pacing sensitivity for NSFW scenes.
public final class NSFWPacingController {
    public var rate: Double
    public init(rate: Double = 1.0) { self.rate = rate }
}

/// Preview NSFW scenes before full render.
public struct NSFWScenePreviewer {
    public func preview(_ text: String) -> String { "[Preview]\n" + text }
}

/// Adjust reverb and spacing for immersive scenes.
public func applyReverbSpacing(to text: String, amount: Double) -> String {
    "[Reverb:\(amount)] " + text
}

/// Manage background FX uploads.
public final class NSFWFXLibraryManager {
    private(set) var fxFiles: [String] = []
    public init() {}
    public func upload(_ name: String) { fxFiles.append(name) }
}

/// Handle transitions from safe to explicit content.
public final class NSFWTransitionManager {
    public init() {}
    public func transition(from current: NSFWStyle, to target: NSFWStyle) -> [NSFWStyle] {
        [current, target]
    }
}

/// Guard NSFW access based on subscription rules.
public struct NSFWScopeGuard {
    public init() {}
    public func hasAccess() -> Bool {
        NSFWPaywallManager.shared.isPremiumUnlocked()
    }
}

/// Track NSFW usage history for tone consistency.
public final class NSFWUsageHistory {
    private var counts: [String: Int] = [:]
    public init() {}
    public func record(scene: String) { counts[scene, default: 0] += 1 }
    public func usage(for scene: String) -> Int { counts[scene, default: 0] }
}

/// Flag NSFW content for moderation review.
public struct NSFWModerationFlagger {
    public init() {}
    public func flag(_ text: String) -> Bool {
        let lower = text.lowercased()
        return lower.contains("illegal") || lower.contains("nonconsensual")
    }
}

/// Detect safe vs unsafe content for previews.
public struct NSFWSafetyDetector {
    public init() {}
    public func isSafe(_ text: String) -> Bool {
        !NSFWModerationFlagger().flag(text)
    }
}

/// Dashboard for managing NSFW scene ratings.
public final class NSFWRatingsDashboard {
    private var ratings: [String: Int] = [:]
    public init() {}
    public func rate(scene: String, score: Int) { ratings[scene] = score }
    public func rating(for scene: String) -> Int? { ratings[scene] }
}

/// Simulate body contact dynamics via rhythmic FX.
public final class BodyContactFXSimulator {
    public init() {}
    public func playRhythm(_ pattern: [String]) -> [String] { pattern }
}

/// Render a PG-13 safe version of a scene.
public struct NSFWPG13Renderer {
    private let replacements = ["sex", "naked", "fuck"]
    public init() {}
    public func renderSafeVersion(of text: String) -> String {
        var safe = text
        for word in replacements { safe = safe.replacingOccurrences(of: word, with: "…", options: .caseInsensitive) }
        return safe
    }
}

/// Track listener skips on NSFW scenes.
public final class NSFWSkipTracker {
    private var skips = 0
    public init() {}
    public func recordSkip() { skips += 1 }
    public var skipCount: Int { skips }
}
