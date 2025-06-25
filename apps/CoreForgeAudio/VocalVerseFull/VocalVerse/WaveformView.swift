#if canImport(SwiftUI)
import SwiftUI

/// Simple animated waveform used in PlayerView.
struct WaveformView: View {
    @Binding var isPlaying: Bool
    @State private var bars: [CGFloat] = Array(repeating: 0.5, count: 20)

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(bars.indices, id: \.self) { i in
                Capsule()
                    .fill(Color.white)
                    .frame(width: 3, height: max(2, bars[i] * 40))
                    .opacity(0.8)
                    .shadow(color: .white, radius: 2)
            }
        }
        .onAppear(perform: animate)
        .onChange(of: isPlaying) { _ in animate() }
    }

    private func animate() {
        if isPlaying {
            withAnimation(.easeInOut(duration: 0.35).repeatForever()) {
                bars = bars.map { _ in CGFloat.random(in: 0.2...1.0) }
            }
        } else {
            bars = Array(repeating: 0.2, count: bars.count)
        }
    }
}
#endif
