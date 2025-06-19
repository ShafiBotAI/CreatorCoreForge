import Foundation

/// Provides configuration for enterprise and white-label clients.
public final class EnterpriseSupport {
    public enum Branding {
        case standard
        case custom(name: String, logoURL: URL?)
    }

    public var branding: Branding
    public var apiEndpoint: URL

    public init(branding: Branding = .standard,
                apiEndpoint: URL = URL(string: "https://api.dataforge.ai")!) {
        self.branding = branding
        self.apiEndpoint = apiEndpoint
    }
}
