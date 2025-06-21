import Foundation

public struct CoreForgeBuildFeatures {
    public init() {}

    public func importFigma(file: String) -> [String] {
        file.split(separator: ",").map { String($0) }
    }

    public func bundle(platforms: [String]) -> [String] {
        platforms.map { "\($0)_bundle" }
    }

    public func debugHints(for message: String) -> [String] {
        guard !message.isEmpty else { return [] }
        return ["Check configuration for \(message)"]
    }
}
