#if canImport(SwiftUI)
import SwiftUI

struct SettingsView: View {
    @AppStorage("nsfwEnabled") private var nsfwEnabled = false
    @AppStorage("parentalPIN") private var parentalPIN = ""
    @State private var showPinPrompt = false
    @State private var inputPIN = ""
    @State private var showIncorrectAlert = false

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
