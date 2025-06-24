import Foundation

/// Generates simple outlines for stories.
public final class OutlineGenerator {
    public init() {}

    /// Create an outline splitting text by blank lines.
    public func generate(from text: String) -> [String] {
        text.components(separatedBy: "\n\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }
}
