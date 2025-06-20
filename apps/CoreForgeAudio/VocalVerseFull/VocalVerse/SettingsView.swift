#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct SettingsView: View {
    @AppStorage("selectedVoice") private var selectedVoice = "Default"
    @AppStorage("nsfwEnabled") private var nsfwEnabled = false
    @AppStorage("parentalPIN") private var parentalPIN = "1234"
    @AppStorage("stealthMode") private var stealthMode = false
    @State private var showPinPrompt = false
    @State private var inputPIN = ""
    @State private var showIncorrectAlert = false

    private let voices = VoiceConfig.voices.map { $0.name }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Voices")) {
                    Picker("Voice", selection: $selectedVoice) {
                        ForEach(voices, id: \.self) { voice in
                            Text(voice)
                        }
                    }
                }

                Section(header: Text("Content")) {
                    Toggle("Allow NSFW", isOn: Binding(
                        get: { nsfwEnabled },
                        set: { newValue in
                            if newValue {
                                showPinPrompt = true
                            } else {
                                nsfwEnabled = false
                                NSFWSoundFXEngine.shared.stopAll()
                            }
                        }))
                }

                Section(header: Text("Security")) {
                    Button("Change PIN") { showPinPrompt = true }
                    Toggle("Stealth Vault", isOn: $stealthMode)
                }
            }
            .navigationTitle("Settings")
            .alert("Incorrect PIN", isPresented: $showIncorrectAlert) {
                Button("OK", role: .cancel) { }
            }
            .sheet(isPresented: $showPinPrompt) {
                PinEntryView(pin: $inputPIN, onDone: handlePinEntry)
            }
        }
    }

    private func handlePinEntry() {
        if inputPIN == parentalPIN {
            nsfwEnabled = true
            NSFWSoundFXEngine.shared.playNSFWScene(
                basePattern: ["moan_soft", "thrust_gentle", "breath_female"],
                intensity: .soft)
        } else if parentalPIN.isEmpty { // set new pin
            parentalPIN = inputPIN
            nsfwEnabled = true
            NSFWSoundFXEngine.shared.playNSFWScene(
                basePattern: ["moan_soft", "thrust_gentle", "breath_female"],
                intensity: .soft)
        } else {
            showIncorrectAlert = true
        }
        inputPIN = ""
        showPinPrompt = false
    }
}

struct PinEntryView: View {
    @Binding var pin: String
    var onDone: () -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SecureField("Enter PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .padding()
                Button("Done", action: onDone)
                    .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Parental PIN")
            .padding()
        }
    }
}
#endif
