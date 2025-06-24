import XCTest

final class MultiverseCollapseEffectTests: XCTestCase {
    func testCollapseScriptCreatesOutput() throws {
        let fm = FileManager.default
        let dir = fm.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try fm.createDirectory(at: dir, withIntermediateDirectories: true)
        let output = dir.appendingPathComponent("out.wav")
        let scriptPath = URL(fileURLWithPath: fm.currentDirectoryPath)
            .appendingPathComponent("scripts/test_multiverse_collapse.py").path

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", scriptPath, output.path]
        try proc.run()
        proc.waitUntilExit()
        if proc.terminationStatus != 0 {
            throw XCTSkip("pydub not available")
        }

        XCTAssertTrue(fm.fileExists(atPath: output.path))
    }
}
