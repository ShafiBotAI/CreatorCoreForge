import Foundation

/// Creates basic landing page HTML for a lead segment.
public struct LandingPageGenerator {
    public init() {}

    public func generateHTML(for segment: String) -> String {
        "<html><body><h1>Welcome \(segment) leads!</h1></body></html>"
    }
}
