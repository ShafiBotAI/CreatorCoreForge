import Foundation

/// Duplicates an outreach campaign with all steps.
public struct CampaignCloner {
    public init() {}

    public func clone(sequence: [String]) -> [String] {
        sequence.map { $0 }
    }
}
