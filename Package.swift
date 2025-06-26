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
        .executable(name: "CoreForgeLibraryApp", targets: ["CoreForgeLibraryApp"]),
        .executable(name: "CoreForgeAudioApp", targets: ["CoreForgeAudioApp"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CreatorCoreForge", path: "Sources/CreatorCoreForge"),
        .executableTarget(name: "CoreForgeLibraryApp",
                          dependencies: ["CreatorCoreForge"],
                          path: "apps/CoreForgeLibrary/LibraryApp/CoreForgeLibraryApp",
                          exclude: ["Info.plist"]),
        .executableTarget(name: "CoreForgeAudioApp",
                          dependencies: ["CreatorCoreForge"],
                          path: "apps/CoreForgeAudio/VocalVerseFull/VocalVerse",
                          exclude: ["Info.plist"]),
        .testTarget(name: "CreatorCoreForgeTests", dependencies: ["CreatorCoreForge"], path: "Tests/CreatorCoreForgeTests"),
        .testTarget(name: "CoreForgeAudioAppTests", dependencies: ["CoreForgeAudioApp"], path: "Tests/CoreForgeAudioAppTests")
    ]
)
