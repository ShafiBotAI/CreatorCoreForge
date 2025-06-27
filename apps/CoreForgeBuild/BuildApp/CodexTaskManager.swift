import SwiftUI

/// Represents a single Codex task with a title and status string.
struct CodexTask: Identifiable {
    let id = UUID()
    var title: String
    var status: String
}

/// Observable manager that tracks active Codex tasks.
class CodexTaskManager: ObservableObject {
    @Published var tasks: [CodexTask] = [
        CodexTask(title: "Parse Prompt", status: "running"),
        CodexTask(title: "Generate Code", status: "pending")
    ]
}
