// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "VerseForgeAI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "VerseForgeAI", targets: ["VerseForgeAI"])
    ],
    dependencies: [],
    targets: [
        .target(name: "VerseForgeAI", resources: [.copy("beats.json")]),
        .testTarget(name: "VerseForgeAITests", dependencies: ["VerseForgeAI"])
    ]
)
