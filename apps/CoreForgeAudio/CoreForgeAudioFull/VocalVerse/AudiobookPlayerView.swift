#if canImport(SwiftUI)
import SwiftUI
import AVFoundation
import CreatorCoreForge

/// Simple audiobook player with seek and bookmark support.
struct AudiobookPlayerView: View {
    let url: URL

    @State private var player: AVPlayer?
    @State private var progress: Double = 0
    @State private var bookmarks: [Double] = []
    @State private var duration: Double = 1
    @State private var isPlaying = false
#if canImport(CoreHaptics)
    @State private var hapticsPrepared = false
#endif
    @State private var showError = false

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
                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .scaleEffect(isPlaying ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.2), value: isPlaying)
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
        .alert("Failed to load audio", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        }
    }

    private func togglePlayback() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
#if canImport(CoreHaptics)
        prepareHapticsIfNeeded()
        _ = HapticDeviceManager.shared.sendVibration(to: "default", intensity: 0.5, duration: 0.1)
#endif
    }

    private func setup() {
        guard FileManager.default.fileExists(atPath: url.path) else {
            showError = true
            return
        }
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

#if canImport(CoreHaptics)
    private func prepareHapticsIfNeeded() {
        guard !hapticsPrepared else { return }
        _ = HapticDeviceManager.shared.pairDevice(id: "default", name: "Default")
        hapticsPrepared = true
    }
#endif
}
#endif
