#if canImport(SwiftUI)
import SwiftUI

/// Preview voices and assign preferences.
struct VoicePreviewAndPreferences: View {
    @Binding var selected: String
    private let voices = VoiceConfig.voiceNames

    var body: some View {
        Picker("Voice", selection: $selected) {
            ForEach(voices, id: \..self) { Text($0) }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    VoicePreviewAndPreferences(selected: .constant("Default"))
}
#endif
