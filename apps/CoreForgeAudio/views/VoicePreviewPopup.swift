#if canImport(SwiftUI)
import SwiftUI
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Simple popup overlay to preview a character voice.
struct VoicePreviewPopup: View {
    var audioURL: URL
    @Binding var isPresented: Bool
    @State private var player: AVAudioPlayer?

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Voice Preview")
                    .font(.headline)
                Spacer()
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            Button(action: playPreview) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
        .shadow(radius: Theme.shadowRadius)
    }

    private func playPreview() {
#if canImport(AVFoundation)
        player = try? AVAudioPlayer(contentsOf: audioURL)
        player?.play()
#endif
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var presented = true
        var body: some View {
            VoicePreviewPopup(audioURL: URL(fileURLWithPath: "/dev/null"), isPresented: $presented)
                .previewLayout(.sizeThatFits)
        }
    }
    return PreviewWrapper()
}
#endif
