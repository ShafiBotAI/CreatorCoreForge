# Next Gen Speech Service

`NextGenSpeechService` offers fully offline speech synthesis and naive recognition. It wraps `FusionVoiceController` for generation and includes a lightweight method to analyze raw audio. Voice profiles now support `depth` and `scope` parameters to adjust resonance and pitch range for more emotional delivery.

## Usage

```swift
let service = NextGenSpeechService()
let profile = VoiceProfile(name: "Demo", depth: 1.2, scope: 1.1)
service.generate(text: "Hello world", profile: profile) { data in
    // play or store `data`
}
let result = service.recognize(Data("hello".utf8))
print(result) // "hello"
```

## Realistic Voiceover Engine

`RealisticVoiceoverEngine.speak` now accepts optional `depth` and `scope` overrides so each line can be delivered with custom resonance and pitch range.

```swift
let engine = RealisticVoiceoverEngine()
let segment = Segment(text: "Welcome back", voice: profile)
engine.speak(segment, emotion: "happy", depth: 1.4, scope: 1.3) { result in
    // handle `result`
}
```
