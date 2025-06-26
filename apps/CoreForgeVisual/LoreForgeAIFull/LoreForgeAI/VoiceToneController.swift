import Foundation

/// Adjusts tone, style, and pacing for dialogue lines.
public final class VoiceToneController {
    public init() {}

    public func adjust(line: String, tone: String, pacing: Double) -> String {
        "\(line)-\(tone)-\(Int(pacing))"
    }
}
