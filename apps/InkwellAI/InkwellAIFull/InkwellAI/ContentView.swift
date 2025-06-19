import SwiftUI

struct ContentView: View {
    @State private var showSettings = false

    var body: some View {
        VStack {
            Text("Inkwell AI")
                .padding()
            Button("Settings") { showSettings.toggle() }
                .buttonStyle(.bordered)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}
