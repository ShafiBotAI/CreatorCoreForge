import Foundation

/// Provides a countdown timer for sleep playback mode.
public final class SleepMode {
    private var timer: Timer?
    public init() {}
    public func start(minutes: Int, handler: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(minutes * 60), repeats: false) { _ in
            handler()
        }
    }
    public func cancel() { timer?.invalidate(); timer = nil }
}
