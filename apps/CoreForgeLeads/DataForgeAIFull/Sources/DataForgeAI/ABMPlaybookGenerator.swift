import Foundation

/// Generates simple ABM playbooks per vertical.
public struct ABMPlaybookGenerator {
    public init() {}

    public func generate(for vertical: String) -> [String] {
        ["Identify top \(vertical) accounts", "Craft personalized outreach", "Schedule demos"]
    }
}
