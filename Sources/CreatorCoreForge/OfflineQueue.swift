import Foundation

/// File-safe async task queue used for offline TTS processing.
public final class OfflineQueue {
    private var tasks: [() -> Void] = []
    private var isProcessing = false

    public init() {}

    /// Add a task to the queue and start processing if needed.
    public func add(_ task: @escaping () -> Void) {
        tasks.append(task)
        process()
    }

    private func process() {
        guard !isProcessing, !tasks.isEmpty else { return }
        isProcessing = true
        let task = tasks.removeFirst()
        DispatchQueue.global().async {
            task()
            DispatchQueue.main.async {
                self.isProcessing = false
                self.process()
            }
        }
    }
}
