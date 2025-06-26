import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct RenderPreviewView: View {
    var frames: [String]

    var body: some View {
        ScrollView {
            ForEach(frames, id: \.self) { frame in
                Text(frame)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke())
            }
        }
    }
}
#else
struct RenderPreviewView {
    var frames: [String]
}
#endif
