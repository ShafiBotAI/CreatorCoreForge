// swift-tools-version:5.7
import PackageDescription

var products: [PackageDescription.Product] = [
    .library(name: "CreatorCoreForge", targets: ["CreatorCoreForge"])
]

#if os(iOS) || os(macOS)
products.append(contentsOf: [
    .executable(name: "CoreForgeLibraryApp", targets: ["CoreForgeLibraryApp"]),
    .executable(name: "CoreForgeAudioApp", targets: ["CoreForgeAudioApp"])
])
#endif

var targets: [PackageDescription.Target] = [
    .target(name: "CreatorCoreForge", path: "Sources/CreatorCoreForge"),
    .testTarget(name: "CreatorCoreForgeTests", dependencies: ["CreatorCoreForge"], path: "Tests/CreatorCoreForgeTests")
]

#if os(iOS) || os(macOS)
targets.append(contentsOf: [
    .executableTarget(name: "CoreForgeLibraryApp",
                      dependencies: ["CreatorCoreForge"],
                      path: "apps/CoreForgeLibrary/LibraryApp/CoreForgeLibraryApp",
                      exclude: ["Info.plist"]),
    .executableTarget(name: "CoreForgeAudioApp",
                      dependencies: ["CreatorCoreForge"],
                      path: "apps/CoreForgeAudio/VocalVerseFull/VocalVerse",
                      exclude: ["Info.plist"]),
    .testTarget(name: "CoreForgeAudioAppTests", dependencies: ["CoreForgeAudioApp"], path: "Tests/CoreForgeAudioAppTests")
])
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
