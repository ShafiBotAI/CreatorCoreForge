import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct AutoUploadPanel: View {
    var onUpload: (String) -> Void
    @State private var platform: String = "YouTube"
    let platforms = ["TikTok", "YouTube"]

    var body: some View {
        VStack {
            Picker("Platform", selection: $platform) {
                ForEach(platforms, id: \.self) { Text($0).tag($0) }
            }
            Button("Upload") { onUpload(platform) }
        }
        .padding()
    }
}
#else
struct AutoUploadPanel {
    var onUpload: (String) -> Void
    func upload(to platform: String) { onUpload(platform) }
}
#endif
