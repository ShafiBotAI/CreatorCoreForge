#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Central entry point for daily usage showing goals and quick actions.
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

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    greetingSection
                    DailyGoalCard(goalMinutes: dailyGoal, progress: Int(usage.totalListeningTime/60))
                    AudioCreditStatusView(credits: subscription.creditsRemaining)
                    ProfileTierCardView(userName: userName, tier: subscription.activePlan.rawValue.capitalized) {
                        showUpgrade = true
                    }
                    QuickStartList(books: Array(library.books.prefix(3)))
                    ImportShortcutsPanel()
                    quickLinksSection
                    TodayHighlightsCarousel(books: library.books)
                }
                .padding()
            }
            .navigationTitle("Home")
            .sheet(isPresented: $showUpgrade) {
                SubscriptionUpgradeView { plan in
                    subscription.upgrade(to: plan)
                }
            }
            .sheet(isPresented: $showExports) {
                NavigationView { ExportQueueView(manager: exportManager) }
            }
            .sheet(isPresented: $showVoices) {
                NavigationView { VoiceMemoryView() }
            }
        }
    }

    private var userName: String {
        email.split(separator: "@").first.map(String.init) ?? "User"
    }

    private var greetingSection: some View {
        HStack {
            Text("Welcome back, \(userName)!")
                .font(.title2)
                .bold()
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var quickLinksSection: some View {
        HStack {
            Button("Saved Voices") { showVoices = true }
                .buttonStyle(.bordered)
            Button("Export History") { showExports = true }
                .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
