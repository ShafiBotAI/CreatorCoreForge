import Foundation
#if canImport(Network)
import Network
#endif

/// Monitors basic network connectivity status.
public final class NetworkMonitor {
    public static let shared = NetworkMonitor()

    #if canImport(Network)
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "network.monitor")
    #endif

    private(set) var _isConnected: Bool = true
    private var overrideActive = false

    public var isConnected: Bool {
        #if canImport(Network)
        return _isConnected
        #else
        return true
        #endif
    }

    /// Overrides the connection status for unit tests.
    func setTestConnection(_ connected: Bool) {
        overrideActive = true
        _isConnected = connected
    }

    private init() {
        #if canImport(Network)
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self, !self.overrideActive else { return }
            self._isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
        #endif
    }
}
