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
    dependencies: [],
    targets: [
        .target(name: "VocalVision"),
        .testTarget(name: "VocalVisionTests", dependencies: ["VocalVision"])
    ]
)
