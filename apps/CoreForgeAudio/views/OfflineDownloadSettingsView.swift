#if canImport(SwiftUI)
import SwiftUI

/// Toggle auto-download, Wi-Fi only preference.
struct OfflineDownloadSettingsView: View {
    @Binding var wifiOnly: Bool

    var body: some View {
        Toggle("Wi-Fi Only Downloads", isOn: $wifiOnly)
    }
}

#Preview {
    OfflineDownloadSettingsView(wifiOnly: .constant(true))
}
#endif
