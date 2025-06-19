import Foundation

/// Provides a simple heuristic structure based on analyzing multiple bestseller books.
/// For demo purposes this engine looks at chapter counts to generate a 5 part outline.
final class BestsellerStructureEngine {
    /// Analyze a list of bestseller book texts and return a common structure outline.
    func analyze(books: [String]) -> [String] {
        guard !books.isEmpty else { return [] }
        let avgChapters = books
            .map { $0.components(separatedBy: "Chapter ").count - 1 }
            .reduce(0, +) / books.count
        let segments = max(5, min(10, avgChapters))
        return (0..<segments).map { index in
            if index == 0 { return "Introduction" }
            if index == segments - 1 { return "Conclusion" }
            if index == segments / 2 { return "Climax" }
            return "Part \(index + 1)"
        }.prefix(5).map { String($0) }
    }
}
