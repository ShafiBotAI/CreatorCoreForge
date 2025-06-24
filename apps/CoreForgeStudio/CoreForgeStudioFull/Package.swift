// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "VocalVision",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "VocalVision", targets: ["VocalVision"])
    ],
    dependencies: [
        .package(name: "CreatorCoreForge", path: "../../..")
    ],
    targets: [
        .target(
            name: "VocalVision",
            dependencies: [
                .product(name: "CreatorCoreForge", package: "CreatorCoreForge")
            ]
        ),
        .testTarget(name: "VocalVisionTests", dependencies: ["VocalVision"])
    ]
)
