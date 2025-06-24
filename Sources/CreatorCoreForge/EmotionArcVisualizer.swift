#if canImport(SwiftUI)
// EmotionArcVisualizer.swift
// CoreForge Audio – Phase 7 Module

import SwiftUI

struct EmotionArcVisualizer: View {
    @ObservedObject var tracker = EmotionalArcTracker.shared

    var character: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Emotion Arc – \(character)")
                .font(.headline)
                .padding(.bottom, 5)

            if tracker.getArc(for: character).isEmpty {
                Text("No data available.")
                    .foregroundColor(.secondary)
            } else {
                GeometryReader { geo in
                    Path { path in
                        let arc = tracker.getArc(for: character)
                        let width = geo.size.width
                        let height = geo.size.height

                        let maxIntensity: CGFloat = 1.0
                        let spacing = width / CGFloat(max(arc.count - 1, 1))

                        for (index, point) in arc.enumerated() {
                            let x = CGFloat(index) * spacing
                            let y = height - (CGFloat(point.intensity) * height / maxIntensity)

                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                    .background(Color.gray.opacity(0.1))
                }
                .frame(height: 150)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
        .padding(.horizontal)
    }
}

// Example usage:
// EmotionArcVisualizer(character: "Zara")
#endif
