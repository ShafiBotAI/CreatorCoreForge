import Foundation

/// Creates personalized lead videos using placeholders.
public struct LeadVideoPersonalizer {
    public init() {}

    public func createVideo(for lead: Lead) -> URL {
        URL(fileURLWithPath: "/tmp/\(lead.name)_video.mp4")
    }
}
