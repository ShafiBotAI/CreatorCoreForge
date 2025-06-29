import Foundation

/// Generates simple mythology elements for world building.
public struct MythologyGenerator {
    public init() {}

    public func generateGod(name: String) -> String {
        "God \(name) rules over fate and dreams."
    }

    public func generateRitual(title: String) -> String {
        "The ritual of \(title) is performed under a full moon."
    }

    public func generateLegend(hero: String) -> String {
        "Legend speaks of \(hero) who saved the realm."
    }
}
