#if canImport(Combine)
import Foundation
import Combine

/// Provides a sleep timer that gradually fades out playback before stopping.
public final class SleepReadMode: ObservableObject {
    public static let shared = SleepReadMode()
    @Published public private(set) var isActive = false
    private var cancellable: AnyCancellable?

    public init() {}

    /// Start sleep mode for the given duration. A fade closure receives values from 1.0 to 0.0.
    public func start(duration: TimeInterval,
                      fadeDuration: TimeInterval = 5.0,
                      fade: @escaping (Float) -> Void,
                      completion: @escaping () -> Void) {
        guard !isActive else { return }
        isActive = true
        let start = Date()
        cancellable = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let elapsed = Date().timeIntervalSince(start)
                if elapsed >= duration {
                    self.cancellable?.cancel()
                    self.isActive = false
                    completion()
                } else if elapsed >= duration - fadeDuration {
                    let progress = Float((elapsed - (duration - fadeDuration)) / fadeDuration)
                    fade(max(0, min(1, 1.0 - progress)))
                }
            }
    }

    /// Cancel any active sleep timer.
    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
        isActive = false
    }
}
#else
import Foundation

public final class SleepReadMode {
    public static let shared = SleepReadMode()
    public private(set) var isActive = false
    private var timer: Timer?
    private var fadeDuration: TimeInterval = 0
    private var fadeHandler: ((Float) -> Void)?
    private var completionHandler: (() -> Void)?
    private var startTime: Date?
    private var duration: TimeInterval = 0

    public init() {}

    public func start(duration: TimeInterval,
                      fadeDuration: TimeInterval = 5.0,
                      fade: @escaping (Float) -> Void,
                      completion: @escaping () -> Void) {
        guard !isActive else { return }
        isActive = true
        self.fadeDuration = fadeDuration
        self.fadeHandler = fade
        self.completionHandler = completion
        self.startTime = Date()
        self.duration = duration
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.handleTimer()
        }
    }

    private func handleTimer() {
        guard let start = startTime else { return }
        let elapsed = Date().timeIntervalSince(start)
        if elapsed >= duration {
            timer?.invalidate()
            timer = nil
            isActive = false
            completionHandler?()
        } else if elapsed >= duration - fadeDuration {
            let progress = Float((elapsed - (duration - fadeDuration)) / fadeDuration)
            fadeHandler?(max(0, min(1, 1.0 - progress)))
        }
    }

    public func cancel() {
        timer?.invalidate()
        timer = nil
        isActive = false
    }
}
#endif
