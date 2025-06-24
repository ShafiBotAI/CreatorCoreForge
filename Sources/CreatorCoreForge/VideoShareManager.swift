import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// Provides a simple way to present the iOS share sheet for a video file.
public enum VideoShareManager {
#if canImport(UIKit)
    /// Returns a configured share sheet for a video URL.
    public static func activityController(for url: URL) -> UIActivityViewController {
        UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    /// Presents a UIActivityViewController from the provided controller.
    public static func presentShareSheet(for url: URL, from controller: UIViewController) {
        let activity = activityController(for: url)
        controller.present(activity, animated: true)
    }
#else
    /// Stub for platforms without UIKit.
    public static func activityController(for url: URL) -> Any {
        url
    }

    /// Stub for platforms without UIKit.
    public static func presentShareSheet(for url: URL, from controller: Any) {
        // no-op
    }
#endif
}
