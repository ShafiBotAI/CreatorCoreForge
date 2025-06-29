import Foundation
import Sentry

/// Lightweight wrapper around SentrySDK used across apps.
public enum SentryIntegration {
    /// Configure Sentry with the given DSN.
    public static func configure(dsn: String) {
        SentrySDK.start { options in
            options.dsn = dsn
        }
    }

    /// Capture a log message for debugging.
    public static func capture(message: String) {
        SentrySDK.capture(message: message)
    }
}
