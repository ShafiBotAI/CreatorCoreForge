import Foundation

/// Suggests voice improvements based on basic heuristics.
public struct VoiceAdvisorAI {
    public init() {}
    public func advise(on text: String) -> String {
        text.count > 100 ? "Consider varying your tone." : "Sounding good!"
    }
}
