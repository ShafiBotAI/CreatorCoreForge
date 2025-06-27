import SwiftUI

/// Displays active Codex tasks and their statuses.
struct CodexAgentPanel: View {
    @StateObject private var manager = CodexTaskManager()

    var body: some View {
        List {
            ForEach(manager.tasks) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    Text(task.status)
                        .foregroundColor(task.status == "running" ? .green : .secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    CodexAgentPanel()
}
