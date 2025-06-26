#if canImport(SwiftUI)
import SwiftUI

/// Gesture helper to preview a voice by swiping or long pressing.
struct SwipePreviewHandler: ViewModifier {
    var audioURL: URL
    @State private var showPreview = false

    func body(content: Content) -> some View {
        content
            .onLongPressGesture { showPreview = true }
            .sheet(isPresented: $showPreview) {
                VoicePreviewPopup(audioURL: audioURL, isPresented: $showPreview)
            }
    }
}

extension View {
    func voicePreviewOnHold(audioURL: URL) -> some View {
        modifier(SwipePreviewHandler(audioURL: audioURL))
    }
}
#endif
