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

#if DEBUG
struct AmbientFXMixerView_Previews: PreviewProvider {
    @State static var level = 0.5
    static var previews: some View {
        AmbientFXMixerView(level: $level)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
