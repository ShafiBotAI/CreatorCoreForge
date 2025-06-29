import Foundation
import Sentry

public enum SentryIntegration {
    public static func start(dsn: String) {
        SentrySDK.start { options in
            options.dsn = dsn
        }
    }

    public static func capture(message: String) {
        SentrySDK.capture(message: message)
    }
}
