// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "TradeMindAI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "TradeMindAI", targets: ["TradeMindAI"])
    ],
    dependencies: [
        // Use a vendored copy of openai-swift to allow offline builds
        .package(path: "../openai-swift"),
        // Shared utilities such as AutoUpdater
        .package(name: "CreatorCoreForge", path: "../../..")
    ],
    targets: [
        .target(
            name: "TradeMindAI",
            dependencies: [
                .product(name: "OpenAI", package: "openai-swift"),
                .product(name: "CreatorCoreForge", package: "CreatorCoreForge")
            ],
            resources: [
                .copy("prompts.json")
            ]
        ),
        .testTarget(name: "TradeMindAITests", dependencies: ["TradeMindAI"])
    ]
)
