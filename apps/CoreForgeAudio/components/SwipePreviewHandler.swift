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

#if DEBUG
struct SwipePreviewHandler_Previews: PreviewProvider {
    static var previews: some View {
        Text("Preview")
            .voicePreviewOnHold(audioURL: URL(fileURLWithPath: "/dev/null"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif

extension View {
    func voicePreviewOnHold(audioURL: URL) -> some View {
        modifier(SwipePreviewHandler(audioURL: audioURL))
    }
}
#endif
