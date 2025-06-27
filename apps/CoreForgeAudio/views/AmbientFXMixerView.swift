#if canImport(SwiftUI)
import SwiftUI

/// Controls ambient sound levels for the current scene or book.
struct AmbientFXMixerView: View {
    @Binding var level: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("Ambient FX")
            Slider(value: $level, in: 0...1)
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var level = 0.5
        var body: some View {
            AmbientFXMixerView(level: $level)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
    return PreviewWrapper()
}
#endif
