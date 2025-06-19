// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LoreForgeAI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "LoreForgeAI", targets: ["LoreForgeAI"])
    ],
    dependencies: [],
    targets: [
        .target(name: "LoreForgeAI", path: "LoreForgeAI"),
        .testTarget(name: "LoreForgeAITests", dependencies: ["LoreForgeAI"], path: "Tests/LoreForgeAITests")
    ]
)
