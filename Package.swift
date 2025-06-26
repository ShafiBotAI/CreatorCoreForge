// swift-tools-version:5.7
import PackageDescription

var products: [Product] = [
    .library(name: "CreatorCoreForge", targets: ["CreatorCoreForge"])
]

#if !os(Linux)
products += [
    .executable(name: "CoreForgeLibraryApp", targets: ["CoreForgeLibraryApp"]),
    .executable(name: "CoreForgeAudioApp", targets: ["CoreForgeAudioApp"])
]
#endif

var targets: [Target] = [
    .target(name: "CreatorCoreForge", path: "Sources/CreatorCoreForge"),
    .testTarget(name: "CreatorCoreForgeTests", dependencies: ["CreatorCoreForge"], path: "Tests/CreatorCoreForgeTests")
]

#if !os(Linux)
targets += [
    .executableTarget(
        name: "CoreForgeLibraryApp",
        dependencies: ["CreatorCoreForge"],
        path: "apps/CoreForgeLibrary/LibraryApp/CoreForgeLibraryApp",
        exclude: ["Info.plist"]
    ),
    .target(name: "CoreForgeAudioModels", path: "apps/CoreForgeAudio/models"),
    .executableTarget(
        name: "CoreForgeAudioApp",
        dependencies: ["CreatorCoreForge", "CoreForgeAudioModels"],
        path: "apps/CoreForgeAudio/VocalVerseFull/VocalVerse",
        exclude: [
            "Info.plist",
            "Assets.xcassets",
            "LaunchScreen.storyboard",
            "prompts.json"
        ]
    ),
    .testTarget(name: "CoreForgeAudioAppTests", dependencies: ["CoreForgeAudioApp"], path: "Tests/CoreForgeAudioAppTests")
]
#endif

let package = Package(
    name: "CreatorCoreForge",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: products,
    dependencies: [],
    targets: targets
)
