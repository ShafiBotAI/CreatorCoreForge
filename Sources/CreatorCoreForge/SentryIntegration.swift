import Foundation
#if canImport(Sentry)
import Sentry
#endif

/// Lightweight wrapper around SentrySDK used across apps.
public enum SentryIntegration {
    /// Configure Sentry with the given DSN.
    public static func configure(dsn: String) {
#if canImport(Sentry)
        SentrySDK.start { options in
            options.dsn = dsn
        }
#else
        print("Sentry not available")
#endif
    }

    /// Capture a log message for debugging.
    public static func capture(message: String) {
#if canImport(Sentry)
        SentrySDK.capture(message: message)
#else
        print("Sentry capture: \(message)")
#endif
    }
}
