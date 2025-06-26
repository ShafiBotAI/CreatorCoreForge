#if canImport(SwiftUI)
import SwiftUI

/// Toggle control for enabling or disabling NSFW mode.
struct NSFWToggleView: View {
    @AppStorage("nsfwEnabled") private var nsfwEnabled = false

    var body: some View {
        Toggle(isOn: $nsfwEnabled) {
            Label("NSFW Mode", systemImage: nsfwEnabled ? "eye" : "eye.slash")
        }
        .toggleStyle(.switch)
        .padding(8)
    }
}

#if DEBUG
struct NSFWToggleView_Previews: PreviewProvider {
    static var previews: some View {
        NSFWToggleView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
