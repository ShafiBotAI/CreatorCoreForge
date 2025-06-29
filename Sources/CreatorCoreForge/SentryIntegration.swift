import Foundation
#if canImport(Sentry)
import Sentry
#endif

public enum SentryIntegration {
#if canImport(Sentry)
    public static func start(dsn: String) {
        SentrySDK.start { options in
            options.dsn = dsn
        }
    }

    public static func capture(message: String) {
        SentrySDK.capture(message: message)
    }
#else
    public static func start(dsn: String) {
        // Sentry not available
    }

    public static func capture(message: String) {
        // Sentry not available
    }
#endif
}
