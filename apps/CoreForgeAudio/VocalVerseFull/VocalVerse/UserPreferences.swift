import Foundation
#if canImport(SwiftUI)
import SwiftUI

/// Shared user preference storage using `@AppStorage`.
/// Provides access across views for settings like NSFW mode and offline options.
final class UserPreferences: ObservableObject {
    static let shared = UserPreferences()

    @AppStorage("nsfwEnabled") var nsfwEnabled: Bool = false
    @AppStorage("wifiOnly") var wifiOnly: Bool = true
    @AppStorage("autoScroll") var autoScroll: Bool = false
    @AppStorage("selectedVoice") var selectedVoice: String = "Default"
    @AppStorage("birthDate") var birthDateString: String = ""
    @AppStorage("parentalPIN") var parentalPIN: String = "1234"
    @AppStorage("offlineMode") var offlineMode: Bool = false

    private init() {}

    /// Returns the user's age in years if a birth date is available.
    var age: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: birthDateString) else { return 0 }
        return Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
    }
}
#endif
