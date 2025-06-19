import Foundation

public struct AppInfo {
    public let name: String
    public let description: String
    public let path: String

    public init(name: String, description: String, path: String) {
        self.name = name
        self.description = description
        self.path = path
    }
}

public enum AppCatalog {
    public static let all: [AppInfo] = [
        AppInfo(name: "DataForgeAI", description: "Lead generation and prospecting toolkit", path: "apps/DataForgeAI"),
        AppInfo(name: "InkwellAI", description: "AI writing assistant for books and series", path: "apps/InkwellAI"),
        AppInfo(name: "LoreForgeAI", description: "Video and story creation suite", path: "apps/LoreForgeAI"),
        AppInfo(name: "VerseForgeAI", description: "Beat and hook generation tools", path: "apps/VerseForgeAI"),
        AppInfo(name: "VocalVision", description: "Book-to-video dramatization engine", path: "apps/VocalVision"),
        AppInfo(name: "TradeMindAI", description: "Trading strategy companion", path: "apps/TradeMindAI"),
        AppInfo(name: "VocalVerse", description: "Voice-driven reader with offline vault", path: "apps/VocalVerse"),
        AppInfo(name: "AppForgeAI", description: "AI-powered app builder", path: "apps/AppForgeAI")
    ]

    public static func info(for name: String) -> AppInfo? {
        return all.first { $0.name.caseInsensitiveCompare(name) == .orderedSame }
    }
}
