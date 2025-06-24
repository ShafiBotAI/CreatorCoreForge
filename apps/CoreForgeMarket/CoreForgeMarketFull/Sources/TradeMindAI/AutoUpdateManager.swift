import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import CreatorCoreForge

/// Exposes a convenience wrapper around the shared `AutoUpdater` for the TradeMindAI package.
public enum AutoUpdateManager {
    /// Checks the provided endpoint for a new version and invokes the completion with the latest version string if one is available.
    /// - Parameters:
    ///   - currentVersion: The current app version.
    ///   - url: Optional custom update URL.
    ///   - session: Optional URLSession for injection during testing.
    public static func checkForUpdate(currentVersion: String,
                                      url: URL? = nil,
                                      session: URLSession = .shared,
                                      completion: @escaping (String?) -> Void) {
        let updater = AutoUpdater(updateURL: url ?? URL(string: "https://example.com/latest.json")!,
                                  session: session)
        updater.checkForUpdate(currentVersion: currentVersion, completion: completion)
    }
}
