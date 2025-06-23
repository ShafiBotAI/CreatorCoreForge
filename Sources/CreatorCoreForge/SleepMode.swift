
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
=======
#if canImport(Combine)
import Foundation
import Combine

/// Simple sleep timer that stops playback after a delay.
public final class SleepMode: ObservableObject {
    public static let shared = SleepMode()
    @Published public private(set) var isActive = false
    private var cancellable: AnyCancellable?

    public init() {}

    /// Start a sleep timer.
    /// - Parameters:
    ///   - duration: time until completion
    ///   - completion: called when the timer fires
    public func start(duration: TimeInterval, completion: @escaping () -> Void) {
        guard !isActive else { return }
        isActive = true
        cancellable = Just(())
            .delay(for: .seconds(duration), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.isActive = false
                completion()
            }
    }

    /// Cancel the current timer if active.
    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
        isActive = false
    }
}
#else
import Foundation

public final class SleepMode {
    public static let shared = SleepMode()
    public private(set) var isActive = false
    private var timer: Timer?

    public init() {}

    public func start(duration: TimeInterval, completion: @escaping () -> Void) {
        guard !isActive else { return }
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.timer = nil
            self?.isActive = false
            completion()
        }
    }

    public func cancel() {
        timer?.invalidate()
        timer = nil
        isActive = false
    }
}
#endif

