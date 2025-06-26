#if canImport(SwiftUI)
import SwiftUI

/// Speed and voice selector used by player controls.
struct PlaybackSpeedControlView: View {
    @Binding var speed: Double
    @Binding var voice: String

    enum PlaybackSpeed: Double, CaseIterable {
        case one = 1.0
        case oneTwentyFive = 1.25
        case oneFifty = 1.5
        case two = 2.0
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
#endif
