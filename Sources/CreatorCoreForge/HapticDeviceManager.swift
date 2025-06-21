import Foundation
#if canImport(CoreHaptics)
import CoreHaptics
#endif

/// Represents a paired haptic device.
public struct HapticDevice: Identifiable, Codable, Equatable {
    public let id: String
    public let name: String
}

/// Manages pairing and basic vibration commands for haptic suits or toys.
public final class HapticDeviceManager {
    public static let shared = HapticDeviceManager()

    private var pairedDevices: [HapticDevice] = []

    public init() {}

    /// Pair a new device with a given identifier and name.
    @discardableResult
    public func pairDevice(id: String, name: String) -> HapticDevice {
        let device = HapticDevice(id: id, name: name)
        if !pairedDevices.contains(device) {
            pairedDevices.append(device)
        }
        return device
    }

    /// Remove a previously paired device.
    public func unpairDevice(id: String) {
        pairedDevices.removeAll { $0.id == id }
    }

    /// List all currently paired devices.
    public func listPairedDevices() -> [HapticDevice] {
        pairedDevices
    }

    /// Send a vibration command to a device if available.
    /// Returns `true` if the command was accepted.
    @discardableResult
    public func sendVibration(to id: String, intensity: Float, duration: TimeInterval) -> Bool {
        guard pairedDevices.contains(where: { $0.id == id }) else {
            return false
        }
        #if canImport(CoreHaptics)
        print("[HapticDeviceManager] Vibrating \(id) at \(intensity) for \(duration)s")
        return true
        #else
        print("[HapticDeviceManager] CoreHaptics not available")
        return false
        #endif
    }
}
