#if canImport(SwiftUI)
import SwiftUI

/// Simple preview panel for a scene clip.
public struct ClipPreviewPanel: View {
    public var clip: SceneClip
    public var onRerender: (() -> Void)?
    public var onAlternate: (() -> Void)?

    public init(clip: SceneClip, onRerender: (() -> Void)? = nil, onAlternate: (() -> Void)? = nil) {
        self.clip = clip
        self.onRerender = onRerender
        self.onAlternate = onAlternate
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(clip.text)
                .padding()
            HStack {
                Button("Play") {}
                Button("Re-render") { onRerender?() }
                Button("Alternate") { onAlternate?() }
            }
            .buttonStyle(.bordered)
            HStack {
                Text(clip.tone).font(.caption2)
                Spacer()
                Text(clip.transitionType).font(.caption2)
            }
            .padding(.horizontal)
            ProgressView(value: Double(clip.sceneIndex % 10) / 10.0)
                .accentColor(.blue)
                .padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke())
        .padding(4)
    }
}

#if DEBUG
struct ClipPreviewPanel_Previews: PreviewProvider {
    static var previews: some View {
        ClipPreviewPanel(clip: SceneClip(clipID: "1", text: "Hello world", sceneIndex: 0, startLine: 0, endLine: 0, tone: "neutral", transitionType: "fade"))
    }
}
#endif

#else
/// Placeholder view when SwiftUI is unavailable.
public struct ClipPreviewPanel {
    public init(clip: SceneClip, onRerender: (() -> Void)? = nil, onAlternate: (() -> Void)? = nil) {}
}
#endif
