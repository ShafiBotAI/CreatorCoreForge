import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// Provides a simple way to present the platform share sheet for a video file.
public enum VideoShareManager {
#if canImport(UIKit)
    /// Returns a configured share sheet for a video URL.
    public static func activityController(for url: URL) -> UIActivityViewController {
        UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    /// Presents a UIActivityViewController from the given controller.
    public static func presentShareSheet(for url: URL, from controller: UIViewController) {
        let activity = activityController(for: url)
        controller.present(activity, animated: true)
    }
#else
    /// Stub for platforms without UIKit. Returns the URL directly.
    public static func activityController(for url: URL) -> Any {
        return url
    }

    /// Stub for platforms without UIKit.
    public static func presentShareSheet(for url: URL, from controller: Any) {
        // no-op on non-UIKit platforms
    }
#endif
}
