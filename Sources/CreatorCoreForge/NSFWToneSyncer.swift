import Foundation

/// Synchronizes NSFW tone with voice and ambient FX layers.
public final class NSFWToneSyncer {
    private let matcher = NSFWAmbientFXMatcher()
    public init() {}

    /// Apply a tone to the provided voice string and replace the ambient FX list
    /// with those best matching the tone.
    public func sync(tone: NSFWStyle, voice: inout String, ambient: inout [String]) {
        voice = "[tone:\(tone.rawValue)] " + voice
        ambient = matcher.fx(for: tone)
    }
}
