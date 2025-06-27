import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

/// Manages playback UI state and provides hooks for SwiftUI views.
public final class PlaybackUIController: ObservableObject {
    @Published public private(set) var isPlaying = false
    @Published public private(set) var progress: Float = 0
    @Published public private(set) var currentTitle: String = ""
    @Published public private(set) var controlsEnabled = true

    public init() {}

    /// Show the play button in the UI.
    public func showPlayButton() {
        isPlaying = true
        #if !canImport(SwiftUI)
        print("\u{25B6}\u{FE0F} Show play button")
        #endif
    }

    /// Show the pause button in the UI.
    public func showPauseButton() {
        isPlaying = false
        #if !canImport(SwiftUI)
        print("\u{23F8}\u{FE0F} Show pause button")
        #endif
    }

    /// Update the playback progress bar to the specified percentage (0.0 - 1.0).
    public func updateProgressBar(to percentage: Float) {
        progress = max(0, min(1, percentage))
        #if !canImport(SwiftUI)
        print("\u{1F4CA} Progress: \(progress * 100)%")
        #endif
    }

    /// Display the title of the currently playing chapter.
    public func displayChapterTitle(_ title: String) {
        currentTitle = title
        #if !canImport(SwiftUI)
        print("\u{1F4D8} Now playing: \(title)")
        #endif
    }

    /// Enable or disable playback controls.
    public func enableControls(_ enabled: Bool) {
        controlsEnabled = enabled
        #if !canImport(SwiftUI)
        print(enabled ? "\u{1F7E2} Controls enabled" : "\u{1F534} Controls disabled")
        #endif
    }
}

#if canImport(SwiftUI)
/// Simple preview view demonstrating playback controls.
struct PlaybackControlsView: View {
    @StateObject var controller = PlaybackUIController()

    var body: some View {
        VStack {
            Text(controller.currentTitle.isEmpty ? "Ready" : controller.currentTitle)
            Slider(value: Binding(get: { Double(controller.progress) },
                                   set: { controller.updateProgressBar(to: Float($0)) }))
            HStack {
                Button(action: controller.showPlayButton) { Text("Play") }
                Button(action: controller.showPauseButton) { Text("Pause") }
            }
            .disabled(!controller.controlsEnabled)
        }
        .padding()
    }
}

#Preview {
    PlaybackControlsView()
        .previewLayout(.sizeThatFits)
}
#endif
