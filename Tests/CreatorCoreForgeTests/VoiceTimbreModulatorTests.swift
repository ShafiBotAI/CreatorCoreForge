import XCTest
@testable import CreatorCoreForge

final class VoiceTimbreModulatorTests: XCTestCase {
    func testProfileAndIntensityUpdate() {
        let mod = VoiceTimbreModulator.shared
        mod.setProfile(.cinematic)
        mod.setIntensity(0.8)
        XCTAssertEqual(mod.activeProfile, .cinematic)
        XCTAssertEqual(mod.modulationIntensity, 0.8, accuracy: 0.001)
    }

    #if canImport(AVFoundation)
    func testApplyReturnsCopy() {
        let mod = VoiceTimbreModulator.shared
        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)!
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 1024)!
        buffer.frameLength = 1024
        let processed = mod.applyTimbre(to: buffer)
        XCTAssertEqual(processed.frameLength, buffer.frameLength)
        XCTAssertFalse(processed === buffer)
    }
    #endif
}
