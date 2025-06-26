import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct VideoExportCreditsView: View {
    var credits: Int
    var plan: String

    var body: some View {
        VStack {
            Text("Credits: \(credits)")
            Text("Plan: \(plan)")
        }
        .padding()
    }
}
#else
struct VideoExportCreditsView {
    var credits: Int
    var plan: String
}
#endif
