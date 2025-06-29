import Foundation

/// Provides a simple influencer list by niche.
public struct InfluencerOutreachList {
    public init() {}

    public func influencers(for niche: String) -> [String] {
        ["top-\(niche)-influencer1", "top-\(niche)-influencer2"]
    }
}
