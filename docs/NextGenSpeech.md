# Next Gen Speech Service

`NextGenSpeechService` offers fully offline speech synthesis and naive recognition. It wraps `FusionVoiceController` for generation and includes a lightweight method to analyze raw audio.

## Usage

```swift
let service = NextGenSpeechService()
let profile = VoiceProfile(name: "Demo")
service.generate(text: "Hello world", profile: profile) { data in
    // play or store `data`
}
let result = service.recognize(Data("hello".utf8))
print(result) // "hello"
```
