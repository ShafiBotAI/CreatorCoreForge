#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Combined profile and settings view.
struct SettingsProfileView: View {
    @EnvironmentObject var usage: UsageStats
    @EnvironmentObject var prefs: UserPreferences
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    SubscriptionStatusCard(tier: usage.subscriptionTier)
                }
                if !isLoggedIn {
                    Section {
                        Text("Create an account to sync your library across devices.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Section("Voice") {
                    VoicePreviewAndPreferences(selected: $prefs.selectedVoice)
                }
                Section("Reading") {
                    AutoScrollToggleView(isOn: $prefs.autoScroll)
                }
                Section("Offline") {
                    OfflineDownloadSettingsView(wifiOnly: $prefs.wifiOnly)
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
        .environmentObject(UserPreferences.shared)
}
#endif
