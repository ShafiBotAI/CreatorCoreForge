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
        AppInfo(name: "CoreForge Leads", description: "Lead generation and prospecting toolkit", path: "apps/CoreForgeLeads"),
        AppInfo(name: "CoreForge Writer", description: "AI writing assistant for books and series", path: "apps/CoreForgeWriter"),
        AppInfo(name: "CoreForge Visual", description: "Video and story creation suite", path: "apps/CoreForgeVisual"),
        AppInfo(name: "CoreForge Music", description: "Beat and hook generation tools", path: "apps/CoreForgeMusic"),
        AppInfo(name: "CoreForge Studio", description: "Book-to-video dramatization engine", path: "apps/CoreForgeStudio"),
        AppInfo(name: "CoreForge Market", description: "Trading strategy companion", path: "apps/CoreForgeMarket"),
        AppInfo(name: "CoreForge Audio", description: "Voice-driven reader with offline vault", path: "apps/CoreForgeAudio"),
        AppInfo(name: "CoreForge Build", description: "AI-powered app builder", path: "apps/CoreForgeBuild")
    ]

    public static func info(for name: String) -> AppInfo? {
        return all.first { $0.name.caseInsensitiveCompare(name) == .orderedSame }
    }
}
