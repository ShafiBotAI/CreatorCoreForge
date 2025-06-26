#if canImport(SwiftUI)
import SwiftUI

/// Displays persistent character to voice assignments across books.
struct VoiceMemoryView: View {
    @State private var assignments: [(String, String)] = []

    var body: some View {
        List(assignments, id: \..0) { character, voice in
            HStack {
                Text(character.capitalized)
                Spacer()
                Text(voice)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear(perform: loadAssignments)
        .navigationTitle("Voice Memory")
    }

    private func loadAssignments() {
        assignments = CharacterVoiceMemory.shared.allAssignments().map { (char, voiceID) in
            let name = VoiceConfig.voices.first { $0.id == voiceID }?.name ?? voiceID
            return (char, name)
        }
    }
}

#if DEBUG
struct VoiceMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMemoryView()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
