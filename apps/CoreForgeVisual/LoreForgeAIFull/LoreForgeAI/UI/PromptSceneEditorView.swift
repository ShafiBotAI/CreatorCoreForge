#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Input form for editing text prompts on a per-scene basis.
struct PromptSceneEditorView: View {
    struct ScenePrompt: Identifiable {
        var id = UUID()
        var text: String
    }

    @State private var scenes: [ScenePrompt] = [ScenePrompt(text: "")]

    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach($scenes) { $scene in
                        TextEditor(text: $scene.text)
                            .frame(height: 80)
                            .padding(8)
                            .background(AppTheme.cardMaterial)
                            .cornerRadius(AppTheme.cornerRadius)
                    }
                }
                .padding(.vertical)
            }
            Button(action: { scenes.append(ScenePrompt(text: "")) }) {
                Label("Add Scene", systemImage: "plus")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.primaryGradient)
                    .foregroundStyle(.white)
                    .cornerRadius(AppTheme.cornerRadius)
            }
        }
        .padding()
    }
}

private struct PromptSceneEditorPreview: View {
    var body: some View {
        PromptSceneEditorView()
    }
}

#Preview {
    PromptSceneEditorPreview()
}
#endif
