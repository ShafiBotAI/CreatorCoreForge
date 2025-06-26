// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CreatorCoreForge",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "CreatorCoreForge", targets: ["CreatorCoreForge"]),
        .executable(name: "CoreForgeLibraryApp", targets: ["CoreForgeLibraryApp"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CreatorCoreForge", path: "Sources/CreatorCoreForge"),
        .executableTarget(name: "CoreForgeLibraryApp",
                          dependencies: ["CreatorCoreForge"],
                          path: "apps/CoreForgeLibrary/LibraryApp/CoreForgeLibraryApp",
                          exclude: ["Info.plist"]),
        .testTarget(name: "CreatorCoreForgeTests", dependencies: ["CreatorCoreForge"], path: "Tests/CreatorCoreForgeTests")
    ]
)
