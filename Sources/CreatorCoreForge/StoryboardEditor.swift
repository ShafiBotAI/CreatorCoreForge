#if canImport(SwiftUI)
import SwiftUI

/// Simple SwiftUI editor for arranging storyboard scenes.
public struct StoryboardEditor: View {
    @State private var scenes: [String]
    @State private var selection: Int?

    public init(scenes: [String] = []) {
        _scenes = State(initialValue: scenes)
    }

    public var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach(Array(scenes.enumerated()), id: \.offset) { index, scene in
                    Text(scene).tag(index)
                }
                .onDelete { scenes.remove(atOffsets: $0) }
            }
            HStack {
                Button("Add Scene") { scenes.append("New Scene") }
                Spacer()
                Text("Timeline: \(scenes.count) shots")
            }
            .padding()
        }
    }
}
#endif
