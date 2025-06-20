# VoiceTrainer Guide

`VoiceTrainer` provides a lightweight way to upload audio samples and generate custom voices entirely offline.

## Usage

```swift
let trainer = VoiceTrainer()
trainer.uploadSample(for: "Hero", filePath: "/path/hero.wav")
if trainer.trainVoice(for: "Hero") {
    trainer.testVoice(character: "Hero", testLine: "Welcome to CoreForge!")
}
```

Use `listTrainedVoices()` to print all available custom voices. Samples can be shared between apps via `VoiceMemoryManager`.
