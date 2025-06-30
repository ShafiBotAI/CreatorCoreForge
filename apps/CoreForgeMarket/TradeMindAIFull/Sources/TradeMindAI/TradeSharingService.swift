import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Enum representing a supported social platform.
public enum SharingPlatform {
    case telegram
    case discord
    case x
}

/// Simple sharing service that posts messages to webhook URLs for each platform.
public struct TradeSharingService {
    private let session: URLSession
    private let webhooks: [SharingPlatform: URL]

    /// Creates the service with optional custom URLSession and webhook mapping.
    /// Webhook URLs can also be provided via environment variables:
    /// `TELEGRAM_WEBHOOK_URL`, `DISCORD_WEBHOOK_URL`, `X_WEBHOOK_URL`.
    public init(session: URLSession = .shared, webhooks: [SharingPlatform: URL] = TradeSharingService.defaultWebhooks()) {
        self.session = session
        self.webhooks = webhooks
    }

    /// Returns webhook URLs from environment variables.
    public static func defaultWebhooks() -> [SharingPlatform: URL] {
        var hooks: [SharingPlatform: URL] = [:]
        let env = ProcessInfo.processInfo.environment
        if let url = env["TELEGRAM_WEBHOOK_URL"].flatMap(URL.init(string:)) {
            hooks[.telegram] = url
        }
        if let url = env["DISCORD_WEBHOOK_URL"].flatMap(URL.init(string:)) {
            hooks[.discord] = url
        }
        if let url = env["X_WEBHOOK_URL"].flatMap(URL.init(string:)) {
            hooks[.x] = url
        }
        return hooks
    }

    /// Sends the message to each platform and returns those that succeeded.
    public func share(message: String, to platforms: [SharingPlatform]) -> [SharingPlatform] {
        var successful: [SharingPlatform] = []
        for platform in platforms {
            guard let url = webhooks[platform] else { continue }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(["message": message])
            let semaphore = DispatchSemaphore(value: 0)
            var wasSuccessful = false
            session.dataTask(with: request) { @Sendable _, response, error in
                if error == nil, let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) {
                    wasSuccessful = true
                }
                semaphore.signal()
            }.resume()
            semaphore.wait()
            if wasSuccessful { successful.append(platform) }
        }
        return successful
    }
}
