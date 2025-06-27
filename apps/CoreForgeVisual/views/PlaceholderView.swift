import SwiftUI

/// Demo view showcasing a minimal CoreForge Visual workflow.
/// Users can compose multiple scene prompts, choose a rendering style,
/// and export the resulting script to a temporary file. The previous
/// placeholder button has been replaced with this functional example.
struct PlaceholderView: View {
    struct Scene: Identifiable {
        var id = UUID()
        var text: String
    }

    @State private var projectTitle = ""
    @State private var scenes: [Scene] = [Scene(text: "")]
    @State private var style = RenderConfig.presets.first ?? "Default"
    @State private var exportCount = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Project Title", text: $projectTitle)
                    .textFieldStyle(.roundedBorder)

                Picker("Style", selection: $style) {
                    ForEach(RenderConfig.presets, id: \.self) { preset in
                        Text(preset).tag(preset)
                    }
                }
                .pickerStyle(.menu)

                List {
                    ForEach($scenes) { $scene in
                        TextEditor(text: $scene.text)
                            .frame(height: 80)
                    }
                    .onDelete { scenes.remove(atOffsets: $0) }
                }

                HStack {
                    Button("Add Scene") { scenes.append(Scene(text: "")) }
                    Spacer()
                    Button("Render Video (\(exportCount))") { exportProject() }
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .navigationTitle("Visual Demo")
        }
    }

    /// Writes the composed scenes to a temporary file to simulate an export.
    private func exportProject() {
        let output = FileManager.default.temporaryDirectory
            .appendingPathComponent("visual-\(UUID().uuidString).txt")
        let content = scenes.map { $0.text }.joined(separator: "\n")
        try? content.write(to: output, atomically: true, encoding: .utf8)
        exportCount += 1
        print("Exported project to \(output.path)")
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
