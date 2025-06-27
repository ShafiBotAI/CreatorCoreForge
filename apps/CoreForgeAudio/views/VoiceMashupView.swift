#if canImport(SwiftUI)
import SwiftUI

/// Simple UI for combining two voices using sample text.
struct VoiceMashupView: View {
    @State private var voiceA: String = VoiceConfig.voiceNames.first ?? ""
    @State private var voiceB: String = VoiceConfig.voiceNames.dropFirst().first ?? VoiceConfig.voiceNames.first ?? ""
    @State private var sampleText: String = "Hello there!"
    @State private var showAlert = false

    var body: some View {
        Form {
            Section("Voice 1") {
                Picker("Voice 1", selection: $voiceA) {
                    ForEach(VoiceConfig.voiceNames, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
            }
            Section("Voice 2") {
                Picker("Voice 2", selection: $voiceB) {
                    ForEach(VoiceConfig.voiceNames, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
            }
            Section("Sample Text") {
                TextField("Text", text: $sampleText)
            }
            Button("Generate Mashup") { showAlert = true }
        }
        .navigationTitle("Voice Mashup")
        .alert("Mashup generated!", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationView { VoiceMashupView() }
}
#endif
