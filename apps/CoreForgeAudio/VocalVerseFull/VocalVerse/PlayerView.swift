#if canImport(SwiftUI)
import SwiftUI
#if canImport(AVFoundation)
import AVFoundation
#endif

struct PlayerView: View {
    @EnvironmentObject var library: LibraryModel
#if canImport(AVFoundation)
    @State private var synthesizer = AVSpeechSynthesizer()
#endif
    @State private var isSpeaking = false

    var body: some View {
        Group {
            if let chapter = library.currentChapter {
                VStack(spacing: 20) {
                    Text(chapter.title)
                        .font(.title)
                    ScrollView {
                        Text(chapter.text)
                            .padding()
                    }
                    Button(isSpeaking ? "Pause" : "Play") {
                        toggleSpeech(text: chapter.text)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            } else {
                Text("Select a chapter from the Library")
                    .font(.headline)
            }
        }
    }

#if canImport(AVFoundation)
    private func toggleSpeech(text: String) {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
            isSpeaking = false
        } else {
            let utterance = AVSpeechUtterance(string: text)
            synthesizer.speak(utterance)
            isSpeaking = true
        }
    }
#else
    private func toggleSpeech(text: String) {}
#endif
}
#endif
