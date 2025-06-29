import Foundation

/// Enum representing a supported social platform.
public enum SharingPlatform {
    case telegram
    case discord
    case x
}

/// Very basic sharing service stub.
public struct TradeSharingService {
    public init() {}

    public func share(message: String, to platforms: [SharingPlatform]) -> [SharingPlatform] {
        // In real implementation, integrate with platform APIs.
        return platforms
    }
}
