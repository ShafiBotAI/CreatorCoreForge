#if canImport(SwiftUI)
import SwiftUI

/// Displays persistent character to voice assignments across books.
struct VoiceMemoryView: View {
    @State private var assignments: [String: [(String, String)]] = [:]

    var body: some View {
        List {
            ForEach(assignments.keys.sorted(), id: \.self) { series in
                Section(header: Text(series.capitalized)) {
                    ForEach(assignments[series]!, id: \.0) { character, voice in
                        HStack {
                            Text(character.capitalized)
                            Spacer()
                            Text(voice)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear(perform: loadAssignments)
        .navigationTitle("Voice Memory")
    }

    private func loadAssignments() {
        let all = CharacterVoiceMemory.shared.allAssignments()
        assignments = Dictionary(uniqueKeysWithValues: all.map { series, map in
            let entries = map.map { (char, id) in
                let name = VoiceConfig.voices.first { $0.id == id }?.name ?? id
                return (char, name)
            }
            return (series, entries)
        })
    }
}

#Preview {
    VoiceMemoryView()
        .previewLayout(.sizeThatFits)
}
#endif
