#if canImport(SwiftUI)
import SwiftUI

/// Dropdown for selecting an active narration voice.
struct VoicePickerView: View {
    @Binding var voice: String
    private let voices = VoiceConfig.voiceNames

    var body: some View {
        Picker("Voice", selection: $voice) {
            ForEach(voices, id: \..self) { Text($0) }
        }
        .pickerStyle(.menu)
    }
}

#if DEBUG
struct VoicePickerView_Previews: PreviewProvider {
    @State static var voice = "Default"
    static var previews: some View {
        VoicePickerView(voice: $voice)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
