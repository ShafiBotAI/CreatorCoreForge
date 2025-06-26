import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

enum VisualStyle: String, CaseIterable {
    case anime
    case liveAction = "live-action"
    case fantasy
    case noir
}

#if canImport(SwiftUI)
struct VisualStylePicker: View {
    @Binding var selection: VisualStyle
    var body: some View {
        Picker("Style", selection: $selection) {
            ForEach(VisualStyle.allCases, id: \.self) { style in
                Text(style.rawValue.capitalized).tag(style)
            }
        }
        .pickerStyle(.segmented)
    }
}
#else
struct VisualStylePicker {
    var selection: VisualStyle
}
#endif
