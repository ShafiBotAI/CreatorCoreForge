import Foundation

/// Very basic text translator used for demos.
struct Translator {
    static func translate(_ text: String, to language: String) -> String {
        guard language.lowercased() != "english" else { return text }
        return "[\(language)] " + text
    }
}
