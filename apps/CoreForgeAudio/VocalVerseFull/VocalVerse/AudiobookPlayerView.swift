#if canImport(SwiftUI)
import SwiftUI
import AVFoundation

/// Simple audiobook player with seek and bookmark support.
struct AudiobookPlayerView: View {
    let url: URL

    @State private var player: AVPlayer?
    @State private var progress: Double = 0
    @State private var bookmarks: [Double] = []
    @State private var duration: Double = 1

    private var timeObserver: Any?

    var body: some View {
        VStack {
            Slider(value: Binding(
                get: { progress },
                set: { newValue in
                    progress = newValue
                    let cm = CMTime(seconds: newValue, preferredTimescale: 600)
                    player?.seek(to: cm)
                }
            ), in: 0...duration)
            .padding()

            HStack(spacing: 40) {
                Button(action: { player?.play() }) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                }
                Button(action: { player?.pause() }) {
                    Image(systemName: "pause.fill")
                        .font(.largeTitle)
                }
                Button(action: addBookmark) {
                    Image(systemName: "bookmark")
                        .font(.largeTitle)
                }
            }
            .padding()

            if !bookmarks.isEmpty {
                List(bookmarks, id: \.self) { time in
                    Button(action: { seek(to: time) }) {
                        Text("Bookmark: \(time, specifier: "%.1f")s")
                    }
                }
            }
        }
        .onAppear(perform: setup)
        .onDisappear { cleanup() }
        .navigationTitle("Player")
    }

    private func setup() {
        player = AVPlayer(url: url)
        duration = player?.currentItem?.asset.duration.seconds ?? 1
        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            progress = time.seconds
        }
    }

    private func cleanup() {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
        player = nil
    }

    private func addBookmark() {
        bookmarks.append(progress)
    }

    private func seek(to time: Double) {
        let cm = CMTime(seconds: time, preferredTimescale: 600)
        player?.seek(to: cm)
    }
}
#endif
