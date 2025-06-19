import SwiftUI

struct ContentView: View {
    @State private var showSettings = false

    var body: some View {
        VStack {
            Text("CoreForge Writer")
                .padding()
            Button("Settings") { showSettings.toggle() }
                .buttonStyle(.bordered)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}
