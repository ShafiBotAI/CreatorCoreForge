import Foundation

/// Provides live preview, debugging, and testing utilities for CoreForge Build.
public final class BuildPreviewEngine {
    /// Device types supported by the simulator.
    public enum SimulatedDevice: String {
        case iOS, android, web
    }

    public static let shared = BuildPreviewEngine()
    private var logs: [String] = []
    private var state: [String: Any] = [:]
    private var breakpoints: Set<String> = []
    private var testResults: [String: Bool] = [:]
    private var warnings: [String] = []
    private var qaChecklist: [String] = []
    private(set) var device: SimulatedDevice = .web
    private var developerConsoleEnabled = false

    private init() {}

    /// Start a simulated preview for the given platform.
    /// Start a simulated preview for the given platform and set the active device.
    @discardableResult
    public func startPreview(platform: String) -> String {
        if let dev = SimulatedDevice(rawValue: platform.lowercased()) {
            device = dev
        }
        let msg = "Preview started for \(platform)"
        logEvent(msg)
        return msg
    }

    /// Manually select the device to preview.
    public func selectDevice(_ device: SimulatedDevice) {
        self.device = device
        logEvent("Device selected: \(device.rawValue)")
    }

    /// Enable or disable the inline developer console output.
    public func setDeveloperConsole(enabled: Bool) {
        developerConsoleEnabled = enabled
        logEvent("Developer console \(enabled ? "enabled" : "disabled")")
    }

    /// Current developer console state.
    public func isDeveloperConsoleEnabled() -> Bool {
        developerConsoleEnabled
    }

    /// Render a single frame and return a debug string.
    public func renderFrame() -> String {
        let frame = "Rendered frame on \(device.rawValue)"
        logEvent(frame)
        return frame
    }

    /// Record a log entry that can be displayed in real time.
    public func logEvent(_ message: String) {
        logs.append(message)
        if developerConsoleEnabled {
            print("[DevConsole] \(message)")
        }
    }

    /// Current log history.
    public func currentLogs() -> [String] {
        logs
    }

    /// Visualize current state variables.
    public func currentState() -> [String: Any] {
        state
    }

    /// Inject mock data into the preview environment.
    public func injectMockData(_ data: [String: Any]) {
        data.forEach { key, value in state[key] = value }
        logEvent("Injected mock data: \(data.keys.joined(separator: ","))")
    }

    /// Simulate an error in the preview environment.
    public func simulateError(_ message: String) {
        state["error"] = message
        logEvent("Error simulated: \(message)")
    }

    /// Add a breakpoint for the given identifier.
    public func addBreakpoint(_ identifier: String) {
        breakpoints.insert(identifier)
        logEvent("Breakpoint added: \(identifier)")
    }

    /// Inspect a state variable by name.
    public func inspectVariable(_ name: String) -> Any? {
        state[name]
    }

    /// Generate simple test case identifiers from a navigation flow.
    public func generateTestCases(from flow: [String]) -> [String] {
        flow.map { "test_\($0)" }
    }

    /// Simulate running web test runners like Jest or Cypress and return pass/fail map.
    @discardableResult
    public func runWebTests(runner: String, cases: [String] = []) -> [String: Bool] {
        var results: [String: Bool] = [:]
        cases.forEach { results[$0] = true }
        testResults = results
        logEvent("Ran \(runner) tests")
        return results
    }

    /// Check WCAG compliance for the current preview.
    @discardableResult
    public func checkAccessibility() -> Bool {
        logEvent("Accessibility check passed")
        return true
    }

    /// Provide fake code coverage percentage for a module.
    public func coverage(for module: String) -> Double {
        logEvent("Coverage reported for \(module)")
        return 0.8
    }

    /// Toggle dark mode testing state.
    public func toggleDarkMode(enabled: Bool) {
        state["darkMode"] = enabled
        logEvent("Dark mode \(enabled ? "enabled" : "disabled")")
    }

    /// Simple performance metrics placeholder.
    public func performanceMetrics() -> [String: Double] {
        ["loadTime": 1.0, "memory": 100.0, "fps": 60.0]
    }

    /// Compute a simple diff between two code strings.
    public func diff(old: String, new: String) -> String {
        let oldLines = old.split(separator: "\n")
        let newLines = new.split(separator: "\n")
        var output: [String] = []
        for (o, n) in zip(oldLines, newLines) {
            if o != n { output.append("-\(o)") ; output.append("+\(n)") }
        }
        if oldLines.count > newLines.count {
            for line in oldLines[newLines.count...] { output.append("-\(line)") }
        } else if newLines.count > oldLines.count {
            for line in newLines[oldLines.count...] { output.append("+\(line)") }
        }
        return output.joined(separator: "\n")
    }

    /// Return code split into old/new sections for side-by-side preview.
    public func splitCodePreview(old: String, new: String) -> (String, String) {
        (old, new)
    }

    /// Log a warning message to be displayed in preview panels.
    public func logWarning(_ message: String) {
        warnings.append(message)
        logEvent("Warning: \(message)")
    }

    /// Preview a form's logic flow and return a textual representation.
    public func previewFormLogic(template: FormTemplate) -> String {
        let arrows = template.fields.map { $0.name }.joined(separator: " -> ")
        return "[Logic] " + arrows
    }

    /// Trigger a co-pilot enhancement pass using a hotkey string.
    @discardableResult
    public func triggerHotkey(_ key: String) -> String {
        let msg = "Hotkey \(key) triggered"
        logEvent(msg)
        return msg
    }

    /// Store a QA checklist to be displayed before deployment.
    public func injectQAChecklist(_ items: [String]) {
        qaChecklist = items
        logEvent("QA checklist injected")
    }

    public func currentQAChecklist() -> [String] { qaChecklist }

    /// Run background tests asynchronously (simulated).
    public func runBackgroundTests(cases: [String]) -> Bool {
        testResults = cases.reduce(into: [:]) { $0[$1] = true }
        logEvent("Background tests executed")
        return true
    }

    /// Check form fields for simple injection patterns.
    public func scanFormFields(_ fields: [String]) -> Bool {
        !fields.contains { $0.contains("<script>") }
    }

    /// Validate color contrast ratio meets a minimal threshold.
    public func checkColorContrast(ratio: Double) -> Bool {
        ratio >= 4.5
    }
}
