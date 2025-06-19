// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "DataForgeAI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "DataForgeAI", targets: ["DataForgeAI"])
    ],
    dependencies: [],
    targets: [
        .target(name: "DataForgeAI"),
        .testTarget(name: "DataForgeAITests", dependencies: ["DataForgeAI"])
    ]
)
