import Foundation

/// Generates simple plot enhancements based on top books.
public struct AIPlotBooster {
    public let topBooks: [String]

    public init(topBooks: [String]) {
        self.topBooks = topBooks
    }

    /// Returns common keywords from the bestseller list.
    public func commonThemes(limit: Int = 5) -> [String] {
        let words = topBooks
            .flatMap { $0.lowercased().split(separator: " ") }
            .map(String.init)
        let counts = words.reduce(into: [:]) { (dict: inout [String: Int], word) in
            dict[word, default: 0] += 1
        }
        return counts.sorted { $0.value > $1.value }.prefix(limit).map { $0.key }
    }

    /// Append theme suggestions to a plot outline.
    public func boost(plot: String) -> String {
        let themes = commonThemes(limit: 3).joined(separator: ", ")
        return plot + "\n\nIncorporate themes: " + themes
    }
}
