#if canImport(SwiftUI)
import SwiftUI

/// Picker for selecting narration tone or emotion per character or chapter.
struct VoiceEmotionControlView: View {
    @Binding var emotion: String
    private let emotions = ["Neutral", "Happy", "Sad", "Angry", "Fear", "Excited"]

    var body: some View {
        Menu {
            ForEach(emotions, id: \..self) { value in
                Button(value) { emotion = value }
            }
        } label: {
            Label(emotion, systemImage: "face.smiling")
                .padding(8)
                .background(AppTheme.cardMaterial)
                .cornerRadius(AppTheme.cornerRadius)
        }
    }
}

#if DEBUG
struct VoiceEmotionControlView_Previews: PreviewProvider {
    @State static var emotion = "Neutral"
    static var previews: some View {
        VoiceEmotionControlView(emotion: $emotion)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
