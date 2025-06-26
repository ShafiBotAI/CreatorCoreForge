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
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
    }
}
#endif
