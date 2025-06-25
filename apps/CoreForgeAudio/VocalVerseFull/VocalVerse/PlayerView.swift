#if canImport(SwiftUI)
import SwiftUI
#if canImport(AVFoundation)
import AVFoundation
#endif

struct PlayerView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
#if canImport(AVFoundation)
    @StateObject private var highlighter = SpeechHighlighter()
#endif
    @State private var isSpeaking = false
#if canImport(AVFoundation)
    @State private var playStart: Date?
#endif

    var body: some View {
        Group {
            if let chapter = library.currentChapter {
                VStack(spacing: 20) {
                    Text(chapter.title)
                        .font(.title)
                    ScrollView {
                        if #available(iOS 15.0, *) {
                            Text(highlightedText(for: chapter.text))
                                .padding()
                        } else {
                            Text(chapter.text)
                                .padding()
                        }
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
        if highlighter.isSpeaking {
            highlighter.pause()
            if let start = playStart {
                usage.addListeningTime(Date().timeIntervalSince(start))
            }
            playStart = nil
            isSpeaking = false
        } else {
            playStart = Date()
            highlighter.onFinish = {
                if let start = playStart {
                    usage.addListeningTime(Date().timeIntervalSince(start))
                }
                playStart = nil
                isSpeaking = false
            }
            highlighter.speak(text)
            isSpeaking = true
        }
    }

    @available(iOS 15.0, *)
    private func highlightedText(for text: String) -> AttributedString {
        var attr = AttributedString(text)
        if let range = highlighter.highlightRange,
           let strRange = Range(range, in: attr) {
            attr[strRange].backgroundColor = .yellow
        }
        return attr
    }
#else
    private func toggleSpeech(text: String) {}
#endif
}
#endif
