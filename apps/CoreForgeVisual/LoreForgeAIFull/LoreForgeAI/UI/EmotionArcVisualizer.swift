import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct EmotionArcVisualizer: View {
    var emotions: [Double]

    var body: some View {
        GeometryReader { geo in
            Path { path in
                guard !emotions.isEmpty else { return }
                let step = geo.size.width / CGFloat(emotions.count - 1)
                path.move(to: CGPoint(x: 0, y: geo.size.height * (1 - emotions[0])))
                for (index, value) in emotions.enumerated().dropFirst() {
                    path.addLine(to: CGPoint(x: CGFloat(index) * step,
                                             y: geo.size.height * (1 - value)))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}
#else
struct EmotionArcVisualizer {
    var emotions: [Double]
}
#endif
