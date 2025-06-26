#if canImport(SwiftUI)
import SwiftUI

/// Speed selector used by `MiniPlayerView` and `PlayerView`.
struct PlaybackSpeedControlView: View {
    @Binding var speed: Double
    @Binding var voice: String

    enum PlaybackSpeed: Double, CaseIterable {
        case one = 1.0
        case oneTwentyFive = 1.25
        case oneFifty = 1.5
        case two = 2.0
        case twoFifty = 2.5
        case three = 3.0
        case four = 4.0
        case five = 5.0
    }

    private let voices = VoiceConfig.voiceNames

    var body: some View {
        HStack {
            Menu {
                ForEach(PlaybackSpeed.allCases, id: \.rawValue) { value in
                    Button("\(value.rawValue, specifier: "%.2gx")") {
                        speed = value.rawValue
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

#if DEBUG
struct PlaybackSpeedControlView_Previews: PreviewProvider {
    @State static var speed = PlaybackSpeed.one.rawValue
    @State static var voice = "Default"
    static var previews: some View {
        PlaybackSpeedControlView(speed: $speed, voice: $voice)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
