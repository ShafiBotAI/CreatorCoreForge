#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Enhanced dashboard view with layout modes and interactive tiles.
struct HomeDashboardView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    @AppStorage("dailyGoal") private var dailyGoal: Int = 30
    @AppStorage("email") private var email: String = ""
    @StateObject private var subscription = SubscriptionManager()
    @StateObject private var exportManager = ExportQueueManager()
    @State private var showUpgrade = false
    @State private var showExports = false
    @State private var showVoices = false
    @State private var showNSFW = false
    @State private var layoutMode: LayoutMode = .studio

    enum LayoutMode: String, CaseIterable, Identifiable {
        case studio, cinematic, zen
        var id: String { self.rawValue }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                headerSection
                layoutSelector
                DailyGoalCard(goalMinutes: dailyGoal,
                               progress: Int(usage.totalListeningTime/60))
                AudioCreditStatusView(credits: subscription.creditsRemaining)
                ProfileTierCardView(userName: userName,
                                     tier: subscription.activePlan.rawValue.capitalized) {
                    showUpgrade = true
                }
                interactiveTiles
                audioVisualizer
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .background(themeBackground)
            .sheet(isPresented: $showUpgrade) { SubscriptionView() }
            .sheet(isPresented: $showVoices) { VoiceMapperView() }
            .sheet(isPresented: $showExports) {
                ExportQueueView(exportManager: exportManager)
            }
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(userName)
                    .font(.largeTitle.bold())
            }
            Spacer()
            Button(action: { showVoices.toggle() }) {
                Image(systemName: "speaker.wave.2")
                    .font(.title2)
            }
        }
    }

    private var layoutSelector: some View {
        Picker("Layout", selection: $layoutMode) {
            ForEach(LayoutMode.allCases) { mode in
                Text(mode.rawValue.capitalized).tag(mode)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.vertical, 8)
    }

    private var interactiveTiles: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                DashboardTile(icon: "plus.circle", title: "New Book") {
                    library.startNewImport()
                }
                DashboardTile(icon: "music.note.list", title: "Customize Cast") {
                    showVoices.toggle()
                }
                DashboardTile(icon: "square.and.arrow.down", title: "Export Queue") {
                    showExports.toggle()
                }
            }
            HStack(spacing: 12) {
                DashboardTile(icon: "eye.slash", title: "NSFW Toggle") {
                    showNSFW.toggle()
                }
                DashboardTile(icon: "waveform", title: "Live Visualizer") {
                    // Reserved for future visualization tools
                }
            }
        }
    }

    private var audioVisualizer: some View {
        HStack(spacing: 4) {
            ForEach(0..<20) { _ in
                Capsule()
                    .fill(Color.blue)
                    .frame(width: 4, height: CGFloat.random(in: 10...40))
            }
        }
        .padding(.vertical, 8)
        .animation(.easeInOut(duration: 0.3), value: UUID())
    }

    private var themeBackground: some View {
        switch layoutMode {
        case .studio:
            return AnyView(Color.black.opacity(0.95))
        case .cinematic:
            return AnyView(
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
        case .zen:
            return AnyView(
                Image("ZenBackdrop")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 8)
                    .opacity(0.7)
            )
        }
    }

    private var userName: String {
        email.components(separatedBy: "@").first?.capitalized ?? "User"
    }
}

struct DashboardTile: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.largeTitle)
                Text(title)
                    .font(.caption)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.15))
            .cornerRadius(12)
        }
    }
}
#endif
