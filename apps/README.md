# Apps Directory

This folder groups each major CreatorCoreForge application. Every app contains its own `README.md` and setup guides.

## NSFW Database Integration
Apps that enable NSFW features should import `NSFWDatabase` from the core package.
This shared database keeps a log of all explicit scenes across the suite.

Example usage:
```swift
let entry = NSFWEntry(label: "Prologue", type: .text, tags: ["Audio"], timestamp: Date())
NSFWDatabase.shared.add(entry)
```
