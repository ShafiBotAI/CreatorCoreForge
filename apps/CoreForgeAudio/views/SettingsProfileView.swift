#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Combined profile and settings view.
struct SettingsProfileView: View {
    @AppStorage("autoScroll") private var autoScroll = false
    @AppStorage("wifiOnly") private var wifiOnly = true
    @AppStorage("selectedVoice") private var selectedVoice = "Default"
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        NavigationView {
            Form {
                Section {
                    SubscriptionStatusCard(tier: usage.subscriptionTier)
                }
                Section("Voice") {
                    VoicePreviewAndPreferences(selected: $selectedVoice)
                }
                Section("Reading") {
                    AutoScrollToggleView(isOn: $autoScroll)
                }
                Section("Offline") {
                    OfflineDownloadSettingsView(wifiOnly: $wifiOnly)
                }
                Section("Appearance") {
                    DarkModeSwitcherView()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsProfileView()
        .environmentObject(UsageStats())
}
#endif
