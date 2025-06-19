// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CreatorCoreForge",
    platforms: [ .iOS(.v14) ],
    products: [
        .library(name: "CreatorCoreForge", targets: ["CreatorCoreForge"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CreatorCoreForge", path: "Sources/CreatorCoreForge"),
        .testTarget(name: "CreatorCoreForgeTests", dependencies: ["CreatorCoreForge"], path: "Tests/CreatorCoreForgeTests")
    ]
)
