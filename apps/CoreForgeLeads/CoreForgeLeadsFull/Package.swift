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
    dependencies: [
        .package(name: "CreatorCoreForge", path: "../../..")
    ],
    targets: [
        .target(
            name: "DataForgeAI",
            dependencies: [
                .product(name: "CreatorCoreForge", package: "CreatorCoreForge")
            ]
        ),
        .testTarget(name: "DataForgeAITests", dependencies: ["DataForgeAI"])
    ]
)
