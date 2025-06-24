import Foundation

/// Inserts vocal tics into lines for designated characters.
public struct CharacterTics {
    private var ticsMap: [String: [String]] = [:]
    public init() {}

    public mutating func setTics(_ tics: [String], for character: String) {
        ticsMap[character] = tics
    }

    public func tics(for character: String) -> [String] {
        ticsMap[character] ?? []
    }

    /// Inserts the first tic after the first word in the line.
    public func applyTics(to line: String, for character: String) -> String {
        guard let tic = ticsMap[character]?.first else { return line }
        var words = line.split(separator: " ")
        guard words.count > 1 else { return line }
        words.insert(Substring(tic), at: 1)
        return words.joined(separator: " ")
    }
}
