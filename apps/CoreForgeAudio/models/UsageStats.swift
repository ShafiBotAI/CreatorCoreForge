import Foundation
#if canImport(Combine)
import Combine

/// Tracks basic usage analytics for the dashboard.
final class UsageStats: ObservableObject {
    @Published var totalListeningTime: TimeInterval = 0
    @Published var importedBooks: Int = 0
    @Published var creditsUsed: Int = 0
    @Published var subscriptionTier: String = "Free"
    @Published var achievements: [String] = []

    func addListeningTime(_ time: TimeInterval) {
        totalListeningTime += time
    }

    func recordImport() {
        importedBooks += 1
    }
}
#else
/// Basic placeholder when Combine isn't available.
final class UsageStats {
    var totalListeningTime: TimeInterval = 0
    var importedBooks: Int = 0
    var creditsUsed: Int = 0
    var subscriptionTier: String = "Free"
    var achievements: [String] = []

    func addListeningTime(_ time: TimeInterval) {
        totalListeningTime += time
    }

    func recordImport() {
        importedBooks += 1
    }
}
#endif
