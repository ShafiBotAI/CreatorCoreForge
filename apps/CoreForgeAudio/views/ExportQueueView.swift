#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// View listing pending and completed export tasks.
struct ExportQueueView: View {
    @ObservedObject var manager: ExportQueueManager
    @State private var completed: [String] = []

    var body: some View {
        List {
            Section(header: Text("Pending")) {
                Text("\(manager.pendingCount) task(s) waiting")
            }
            Section(header: Text("Completed")) {
                ForEach(completed, id: \..self) { item in Text(item) }
            }
        }
        .navigationTitle("Export Queue")
    }
}

#Preview {
    class DummyManager: ExportQueueManager {
        override var pendingCount: Int { 2 }
    }
    return NavigationView {
        ExportQueueView(manager: DummyManager())
    }
}
#endif
#endif
