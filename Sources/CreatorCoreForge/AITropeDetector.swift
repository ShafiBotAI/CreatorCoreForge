import Foundation

/// Detects common fiction tropes and optionally rewrites them.
public struct AITropeDetector {
    /// Default list of trope phrases to scan for.
    public static var commonTropes: [String] = [
        "once upon a time",
        "dark and stormy night",
        "chosen one",
        "ancient prophecy"
    ]

    /// Return all tropes found in the provided text.
    public static func detect(in text: String) -> [String] {
        let lower = text.lowercased()
        return commonTropes.filter { lower.contains($0) }
    }

    /// Replace detected tropes with a short phrase encouraging originality.
    public static func breakTropes(in text: String) -> String {
        var output = text
        for trope in commonTropes {
            if output.lowercased().contains(trope) {
                output = output.replacingOccurrences(of: trope, with: "unexpected twist", options: .caseInsensitive)
            }
        }
        return output
    }
}
