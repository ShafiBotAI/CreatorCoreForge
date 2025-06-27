#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge
#if canImport(AVFoundation)
import AVFoundation
#endif

struct PlayerView: View {
    var namespace: Namespace.ID
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    @EnvironmentObject var prefs: UserPreferences
#if canImport(AVFoundation)
    @StateObject private var highlighter = SpeechHighlighter()
#endif
    @State private var isSpeaking = false
#if canImport(AVFoundation)
    @State private var playStart: Date?
#endif
    @State private var speed: Double = 1.0
    @State private var voice: String = VoiceConfig.voices.first?.name ?? "Default"

    private var gradient: LinearGradient {
        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var body: some View {
        Group {
            if let chapter = library.currentChapter {
                VStack(spacing: 20) {
                    Text(chapter.title)
                        .font(.title)
                        .foregroundColor(.white)
                    ScrollView {
                        if #available(iOS 15.0, *) {
                            Text(highlightedText(for: chapter.text))
                                .padding()
                                .foregroundColor(.white)
                        } else {
                            Text(chapter.text)
                                .padding()
                                .foregroundColor(.white)
                        }
                    }
                    WaveformView(isPlaying: $isSpeaking)
                        .frame(height: 40)
                    Button(isSpeaking ? "Pause" : "Play") {
                        toggleSpeech(text: chapter.text)
                    }
                    .buttonStyle(.borderedProminent)
                    PlaybackSpeedControlView(speed: $speed, voice: $voice)
                }
                .padding()
                .background(gradient.ignoresSafeArea())
                .matchedGeometryEffect(id: "player", in: namespace)


            } else {
                Text("Select a chapter from the Library")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(gradient.ignoresSafeArea())
            }
        }
    }

#if canImport(AVFoundation)
    private func toggleSpeech(text: String) {
        guard ContentPolicyManager.isAllowed(text: text, nsfw: prefs.nsfwEnabled, age: prefs.age) else {
            isSpeaking = false
            return
        }
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
