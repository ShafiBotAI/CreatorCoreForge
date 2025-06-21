import Foundation

/// Utility for bundling builds for multiple platforms.
public struct AutoBundler {
    public init() {}
    /// Returns bundled package names for the specified platforms.
    public func bundle(platforms: [String]) -> [String] {
        platforms.map { "\($0)_bundle" }
    }
}
