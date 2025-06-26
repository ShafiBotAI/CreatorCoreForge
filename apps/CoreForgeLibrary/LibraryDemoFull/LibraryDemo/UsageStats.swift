import Foundation
import Combine

/// Tracks library usage metrics for the dashboard.
final class UsageStats: ObservableObject {
    @Published var booksRead: Int = 0
    @Published var hoursListened: TimeInterval = 0
    @Published var favorites: Int = 0
}
