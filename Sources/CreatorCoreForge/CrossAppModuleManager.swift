import Foundation

/// Simple registry for cross-application modules.
/// Apps can register shared feature providers so other apps can access them.
public class CrossAppModuleManager {
    public static let shared = CrossAppModuleManager()

    private var modules: [String: Any] = [:]
    private let queue = DispatchQueue(label: "cross.app.module.queue")

    private init() {}

    /// Register a shared module by name.
    public func register<T>(_ module: T, named name: String) {
        queue.sync { modules[name] = module }
    }

    /// Retrieve a shared module by name.
    public func module<T>(named name: String) -> T? {
        queue.sync { modules[name] as? T }
    }
}
