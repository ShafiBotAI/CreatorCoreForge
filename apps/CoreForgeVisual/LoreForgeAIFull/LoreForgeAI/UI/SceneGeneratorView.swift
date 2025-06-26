import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct SceneGeneratorView: View {
    @State private var scriptText: String = ""
    var onGenerate: (String) -> Void

    var body: some View {
        VStack {
            TextEditor(text: $scriptText)
                .border(Color.gray)
            Button("Generate") { onGenerate(scriptText) }
        }
        .padding()
    }
}
#else
struct SceneGeneratorView {
    var onGenerate: (String) -> Void
    func generate(from text: String) { onGenerate(text) }
}
#endif
