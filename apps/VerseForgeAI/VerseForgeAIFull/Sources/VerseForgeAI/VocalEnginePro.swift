import Foundation

public struct VocalEnginePro {
    public var nsfwFilteringEnabled: Bool

    public init(nsfwFilteringEnabled: Bool = true) {
        self.nsfwFilteringEnabled = nsfwFilteringEnabled
    }

    /// Match vocal tempo to the given beat per minute (BPM)
    public func matchTempo(vocals: [Float], to bpm: Int) -> [Float] {
        guard bpm > 0 else { return vocals }
        let factor = Float(bpm) / 120.0
        return vocals.map { $0 * factor }
    }

    /// Filter explicit lyrics using `ContentPolicyManager`
    public func filterExplicitLyrics(_ lyrics: String) -> String {

        guard nsfwFilteringEnabled else { return lyrics }
        return ContentPolicyManager.sanitize(lyrics)
    }
}
