import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

/// Simple dashboard showing scheduled uploads.
#if canImport(SwiftUI)
struct SchedulerDashboard: View {
    @ObservedObject private var model = ScheduleModel.shared

    var body: some View {
        List {
            ForEach(model.items) { item in
                HStack {
                    Text(item.url.lastPathComponent)
                    Spacer()
                    Text(item.date, style: .date)
                }
            }
        }
        .navigationTitle("Upload Schedule")
    }
}
#else
struct SchedulerDashboard {}
#endif

#if canImport(SwiftUI)
final class ScheduleModel: ObservableObject {
    static let shared = ScheduleModel()
    @Published var items: [ScheduleItem] = []

    private let scheduler = UploadScheduler()

    struct ScheduleItem: Identifiable {
        let id = UUID()
        let url: URL
        let platform: UploadScheduler.Platform
        let date: Date
    }

    func schedule(url: URL, platform: UploadScheduler.Platform, date: Date) {
        items.append(ScheduleItem(url: url, platform: platform, date: date))
        items.sort { $0.date < $1.date }
        scheduler.scheduleUpload(url: url, platform: platform, at: date)
    }
}
#else
final class ScheduleModel {
    static let shared = ScheduleModel()
    func schedule(url: URL, platform: UploadScheduler.Platform, date: Date) {}
    var items: [ScheduleItem] { [] }
    struct ScheduleItem { let id = UUID(); let url: URL; let platform: UploadScheduler.Platform; let date: Date }
}
#endif
