import Foundation

public enum AppArchitecture {
    case spa
    case mvc
    case mvvm
    case unknown
}

/// Detects simple architecture keywords from a prompt.
public struct ArchitectureDetector {
    public init() {}

    public func detect(in text: String) -> AppArchitecture {
        let lower = text.lowercased()
        if lower.contains("single page") || lower.contains("spa") {
            return .spa
        }
        if lower.contains("model-view-controller") || lower.contains("mvc") {
            return .mvc
        }
        if lower.contains("mvvm") {
            return .mvvm
        }
        return .unknown
    }
}
