#if canImport(SwiftUI)
import SwiftUI

/// Speed selector used by `MiniPlayerView` and `PlayerView`.
struct PlaybackSpeedControlView: View {
    @Binding var speed: Double
    private let speeds: [Double] = [1.0, 1.25, 1.5, 2.0]

    var body: some View {
        Menu {
            ForEach(speeds, id: \.self) { value in
                Button("\(value, specifier: "%.2gx")") {
                    speed = value
                }
            }
        } label: {
            Text("\(speed, specifier: "%.2gx")")
                .foregroundColor(.primary)
        }
    }
}
#endif

