#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

enum WritingStyle: String, CaseIterable {
    case standard, formal, casual
}

struct SettingsView: View {
    @AppStorage("nsfwEnabled") private var nsfwEnabled = false
    @AppStorage("parentalPIN") private var parentalPIN = ""
    @AppStorage("nsfwMode") private var nsfwModeRaw = NSFWContentMode.slow.rawValue
    @AppStorage("writingStyle") private var writingStyleRaw = WritingStyle.standard.rawValue
    @AppStorage("largeText") private var largeTextEnabled = false
    @State private var showPinPrompt = false
    @State private var inputPIN = ""
    @State private var showIncorrectAlert = false

    private var nsfwMode: NSFWContentMode {
        get { NSFWContentMode(rawValue: nsfwModeRaw) ?? .slow }
        set { nsfwModeRaw = newValue.rawValue }
    }

    private var writingStyle: WritingStyle {
        get { WritingStyle(rawValue: writingStyleRaw) ?? .standard }
        set { writingStyleRaw = newValue.rawValue }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Content")) {
                    Toggle("Allow NSFW", isOn: Binding(
                        get: { nsfwEnabled },
                        set: { newValue in
                            if newValue {
                                showPinPrompt = true
                            } else {
                                nsfwEnabled = false
                            }
                        }))
                    if nsfwEnabled {
                        Picker("NSFW Mode", selection: Binding(
                            get: { nsfwMode },
                            set: { nsfwMode = $0 })) {
                            ForEach(NSFWContentMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue.capitalized).tag(mode)
                            }
                        }
                    }
                }
                Section(header: Text("Style")) {
                    Picker("Writing Style", selection: Binding(
                        get: { writingStyle },
                        set: { writingStyle = $0 })) {
                        ForEach(WritingStyle.allCases, id: \.self) { style in
                            Text(style.rawValue.capitalized).tag(style)
                        }
                    }
                }
                Section(header: Text("Accessibility")) {
                    Toggle("Large Text", isOn: $largeTextEnabled)
                }
                Section(header: Text("Security")) {
                    Button("Change PIN") { showPinPrompt = true }
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
        } else if parentalPIN.isEmpty {
            parentalPIN = inputPIN
            nsfwEnabled = true
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
