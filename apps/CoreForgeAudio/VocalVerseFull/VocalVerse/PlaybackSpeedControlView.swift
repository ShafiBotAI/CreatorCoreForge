#if canImport(SwiftUI)
import SwiftUI

/// Speed and voice selector used by player controls.
struct PlaybackSpeedControlView: View {
    @Binding var speed: Double
    @Binding var voice: String
    private let speeds: [Double] = [1.0, 1.25, 1.5, 2.0]
    private let voices = VoiceConfig.voices.map { $0.name }

    var body: some View {
        HStack {
            Menu {
                ForEach(speeds, id: \.self) { value in
                    Button("\(value, specifier: "%.2gx")") {
                        speed = value
                    }
                }
            } label: {
                Text("\(speed, specifier: "%.2gx")")
            }
            Menu {
                ForEach(voices, id: \.self) { v in
                    Button(v) { voice = v }
                }
            } label: {
                Text(voice)
            }
        }
    }
}
#endif
