import Foundation

/// Provides short periodic news summaries.
public final class NewsWhisperer {
    private let interval: TimeInterval
    private var timer: Timer?
    private let handler: ([String]) -> Void

    public init(interval: TimeInterval = 900, handler: @escaping ([String]) -> Void) {
        self.interval = interval
        self.handler = handler
    }

    public func start(headlines: @escaping () -> [String]) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            let news = Array(headlines().prefix(3))
            self.handler(news)
        }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}
