#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct SettingsView: View {
    @AppStorage("selectedVoice") private var selectedVoice = "Default"
    @AppStorage("nsfwEnabled") private var nsfwEnabled = false
    @AppStorage("parentalPIN") private var parentalPIN = "1234"
    @AppStorage("birthDate") private var birthDateString = ""
    @AppStorage("stealthMode") private var stealthMode = false
    @State private var showPinPrompt = false
    @State private var showAgeSheet = false
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
                                showAgeSheet = true
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
            .sheet(isPresented: $showAgeSheet) {
                AgeVerificationView(isPresented: $showAgeSheet) { date in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    birthDateString = formatter.string(from: date)
                    showPinPrompt = true
                }
            }
            .sheet(isPresented: $showPinPrompt) {
                PinEntryView(pin: $inputPIN, onDone: handlePinEntry)
            }
        }
    }

    private func handlePinEntry() {
        guard !birthDateString.isEmpty else {
            showAgeSheet = true
            inputPIN = ""
            showPinPrompt = false
            return
        }
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
