import XCTest
@testable import CreatorCoreForge

final class NSFWHabitBehaviorSimulatorTests: XCTestCase {
    func testHabitRegistrationAndSimulation() {
        let simulator = NSFWHabitBehaviorSimulator.shared
        simulator.clearHabits()
        simulator.registerHabit(for: "Kai",
                                behavior: "groans",
                                triggerWords: ["kiss"],
                                responseSoundFile: "groan1.wav",
                                frequency: 1.0)
        let result = simulator.simulate(for: "I will kiss you", character: "Kai")
        XCTAssertEqual(result, "groan1.wav")
    }

    func testClearHabits() {
        let simulator = NSFWHabitBehaviorSimulator.shared
        simulator.registerHabit(for: "Test", behavior: "test", triggerWords: ["a"], responseSoundFile: "a.wav")
        simulator.clearHabits(for: "Test")
        let result = simulator.simulate(for: "a", character: "Test")
        XCTAssertNil(result)
    }
}
