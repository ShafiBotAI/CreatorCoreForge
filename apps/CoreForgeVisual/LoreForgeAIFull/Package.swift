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
    dependencies: [
        .package(name: "CreatorCoreForge", path: "../../..")
    ],
    targets: [
        .target(
            name: "LoreForgeAI",
            dependencies: [
                .product(name: "CreatorCoreForge", package: "CreatorCoreForge")
            ],
            path: "LoreForgeAI"
        ),
        .testTarget(name: "LoreForgeAITests", dependencies: ["LoreForgeAI"], path: "Tests/LoreForgeAITests")
    ]
)
