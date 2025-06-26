import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct CharacterVoiceAssignmentView: View {
    @State private var assignments: [String: String] = [:]
    var characters: [String]
    var voices: [String]

    var body: some View {
        List(characters, id: \.self) { character in
            Picker(character, selection: Binding(
                get: { assignments[character] ?? voices.first ?? "" },
                set: { assignments[character] = $0 }
            )) {
                ForEach(voices, id: \.self) { voice in
                    Text(voice).tag(voice)
                }
            }
        }
    }
}
#else
struct CharacterVoiceAssignmentView {
    var characters: [String]
    var voices: [String]
    var assignments: [String: String] = [:]
}
#endif
