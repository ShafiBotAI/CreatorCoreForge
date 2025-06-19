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
        AppInfo(name: "CoreForge Leads", description: "Lead generation and prospecting toolkit", path: "apps/DataForgeAI"),
        AppInfo(name: "CoreForge Writer", description: "AI writing assistant for books and series", path: "apps/InkwellAI"),
        AppInfo(name: "CoreForge Visual", description: "Video and story creation suite", path: "apps/LoreForgeAI"),
        AppInfo(name: "CoreForge Music", description: "Beat and hook generation tools", path: "apps/VerseForgeAI"),
        AppInfo(name: "CoreForge Studio", description: "Book-to-video dramatization engine", path: "apps/VocalVision"),
        AppInfo(name: "CoreForge Market", description: "Trading strategy companion", path: "apps/TradeMindAI"),
        AppInfo(name: "CoreForge Audio", description: "Voice-driven reader with offline vault", path: "apps/VocalVerse"),
        AppInfo(name: "CoreForge Build", description: "AI-powered app builder", path: "apps/AppForgeAI")
    ]

    public static func info(for name: String) -> AppInfo? {
        return all.first { $0.name.caseInsensitiveCompare(name) == .orderedSame }
    }
}
