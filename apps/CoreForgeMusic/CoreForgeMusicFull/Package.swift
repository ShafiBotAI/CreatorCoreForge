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
    dependencies: [
        .package(name: "CreatorCoreForge", path: "../../..")
    ],
    targets: [
        .target(
            name: "VerseForgeAI",
            dependencies: [
                .product(name: "CreatorCoreForge", package: "CreatorCoreForge")
            ],
            resources: [.copy("beats.json")]
        ),
        .testTarget(name: "VerseForgeAITests", dependencies: ["VerseForgeAI"])
    ]
)
