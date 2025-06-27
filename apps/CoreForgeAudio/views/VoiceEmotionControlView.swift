#if canImport(SwiftUI)
import SwiftUI

/// Picker for selecting narration tone or emotion per character or chapter.
struct VoiceEmotionControlView: View {
    @Binding var emotion: String
    private let emotions = ["Neutral", "Happy", "Sad", "Angry", "Fear", "Excited"]

    var body: some View {
        Menu {
            ForEach(emotions, id: \.self) { value in
                Button(value) { emotion = value }
            }
        } label: {
            Label(emotion, systemImage: "face.smiling")
                .padding(8)
                .background(Theme.cardMaterial)
                .cornerRadius(Theme.cornerRadius)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var emotion = "Neutral"
        var body: some View {
            VoiceEmotionControlView(emotion: $emotion)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
    return PreviewWrapper()
}
#endif
