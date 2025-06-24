# Changelog

## [Unreleased]
- Implemented `VoicePersonalityProfiles` and `DynamicEmotionRamping` utilities.
- Marked initial CoreForge Audio checklist items as complete and added tests.
- Added `SceneDetector` module for basic scene analysis.
- Optimized `SegmentService` with chunked async processing and LRU caching.
- Completed the first twenty CoreForge Build tasks with `AdvancedBuildService`
  and updated README and AGENTS checklists.
- Added layout instruction parsing to `MarkdownLayoutParser` and updated Build AGENTS checklist.
- Implemented `TTSRenderer` and Vue-based `ChapterEditor`, closing related open tasks.
- Ran `scripts/full_app_scan.py` and updated readiness checklist. Verified test suites via `run_all_tests.sh`.
- Measured `full_app_scan.py` runtime (0.11s, ~14.7 MB) via new `measure_performance.py` and confirmed tests pass.
- Added developer console toggle to `BuildPreviewEngine`.
- Added `UnifiedAudioEngine` shared module and updated all app feature lists.
- Added `UnifiedVideoEngine` and `AdaptiveLearningEngine` modules for cross-platform video rendering and adaptive learning.
- Enhanced `AdaptiveLearningEngine` to track lesson completion timestamps.
- Added `HeatmapAnalytics` and `VersionedExports` features to `CoreForgeAudio` in `features-phase8.json`.
- Added `SleepMode` utility and accompanying unit tests.
- Added audio personalization and immersive feature placeholders (`ReplayAnalyticsService`, `SleepReadMode`, `EmotionShiftTracker`, `VoiceReviewSystem`, `AutoCastingEngine`, `PronunciationEditor`, `NarrationScheduler`, `SpatialAudioSupport`, `EmotionPacingEditor`, `SmartAmbientMixer`, `AutoRemixMode`, `AccessibilityOutput`, `WatchSyncService`, `VoicePolls`, `HeartRateAdaptiveAudio`, `UnlockableVoiceSkins`, `PersonalizedGreetingService`, `AdvancedTimelineEditor`, `BrailleOutputService`, `PronunciationDictionary`) to `CoreForgeAudio` in `features-phase8.json`.
- Added `CharacterTrackManager`, `DAWSessionExporter`, `SceneTimeline`, and `SceneHeatmapManager` modules for Phase 9 audio tasks.
- Added placeholder implementations for Visual and Writer features (`StoryboardImporter`, `SceneSegmenter`, `StyleEngine`, `FrameRenderer`, `OutlineGenerator`, `WorldMemoryService`, `BranchService`, `ExportService`).
- Added Studio feature stubs (`MultiTrackEditor`, `LiveEnsembleRoom`, `MacroWorkflowEngine`, `ExportProduction`) with unit tests.
- Replaced placeholder implementations for `DynamicChapterTransitions`, `AdaptiveMusicGenerator`,
  `PronunciationEditor`, `VoiceControlService`, and `AdvancedTimelineEditor` with
  functional modules.
- Added cross-app `VideoEffectsPipeline` with fade transitions and watermark support. Updated `features-phase8.json` and documentation.
- Added cross-app `AudioEffectsPipeline` with echo and pitch-shift utilities. Updated `features-phase8.json` and documentation.

- Added `CrossPlatformVideoGenerator` and `AdaptiveLearningEngine` modules with corresponding Phase 8 entries.
- Added `AmbientFXEngine` and `FXLibrary` modules to manage immersive ambient playback for CoreForge Audio Phase 3.
- Optimized `LensFlareService` and `CacheService` for improved video rendering performance.
- Further optimized lens flare detection loops and added TTL-based eviction to `CacheService`.
- Implemented `multitrack_export` utility and `VoiceApprovalWorkflow` helpers for CoreForge Audio.

