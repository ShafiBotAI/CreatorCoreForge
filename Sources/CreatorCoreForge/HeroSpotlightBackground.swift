import Foundation

/// Generates a simple wide hero spotlight background frame grid.
public struct HeroSpotlightBackground {
    public init() {}
    /// Creates a 3-row background with the hero label centered in the middle row.
    /// - Parameters:
    ///   - width: Width of the frame grid.
    ///   - hero: Hero identifier to highlight.
    /// - Returns: 2D array representing the background grid.
    public func generate(width: Int, hero: String) -> [[String]] {
        guard width > 0 else { return [] }
        var grid = Array(repeating: Array(repeating: "bg", count: width), count: 3)
        let center = width / 2
        grid[1][center] = hero
        return grid
    }
}
