import Foundation

/// Stores compliance information used when building App Store packages.
public struct AppStoreMetadataConfig: Codable {
    public var ageRating: Int
    public var containsNSFW: Bool

    public init(ageRating: Int = 17, containsNSFW: Bool = false) {
        self.ageRating = ageRating
        self.containsNSFW = containsNSFW
    }
}
