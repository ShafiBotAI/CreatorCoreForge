import Foundation

/// Provides unified access to core audio modules for the app UI and services.
public struct CoreForgeAudioIntegrator {
    public let voiceManager: VoiceManager
    public let ambientMixer: AmbientMixer
    public let exportSystem: ExportSystem
    public let segmentEngine: SegmentEngine
    public let nsfwMode: NSFWMode
    public let offlineQueue: OfflineQueue
    public let settings: AppSettings
    public let memoryEngine: MemoryEngine
    public let playbackController: AudioPlaybackController

    public init(settings: AppSettings = .shared) {
        self.voiceManager = VoiceManager()
        self.ambientMixer = AmbientMixer()
        self.exportSystem = ExportSystem()
        self.segmentEngine = SegmentEngine()
        self.nsfwMode = NSFWMode(settings: settings)
        self.offlineQueue = OfflineQueue()
        self.settings = settings
        self.memoryEngine = MemoryEngine()
        self.playbackController = AudioPlaybackController()
    }
}
