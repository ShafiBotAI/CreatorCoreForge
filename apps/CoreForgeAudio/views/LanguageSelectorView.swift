#if canImport(SwiftUI)
import SwiftUI

/// Picker for selecting narration language per book or chapter.
struct LanguageSelectorView: View {
    @Binding var language: String
    private let languages = ["English", "Spanish", "French", "German", "Japanese"]

    var body: some View {
        Picker("Language", selection: $language) {
            ForEach(languages, id: \..self) { Text($0) }
        }
        .pickerStyle(.menu)
    }
}
#endif
