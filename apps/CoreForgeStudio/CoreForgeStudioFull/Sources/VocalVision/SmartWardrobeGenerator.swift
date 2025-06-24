import Foundation

/// Generates simple wardrobe suggestions based on scene tone.
public struct SmartWardrobeGenerator {
    public static func outfit(for tone: String) -> String {
        switch tone.lowercased() {
        case "dark": return "Leather ensemble"
        case "bright": return "Colorful casual"
        default: return "Neutral costume"
        }
    }
}
