// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "iOSApps",
    platforms: [ .iOS(.v14) ],
    products: [
        .library(name: "iOSApps", targets: ["iOSApps"])
    ],
    dependencies: [],
    targets: [
        .target(name: "iOSApps", path: "Sources/iOSApps"),
        .testTarget(name: "iOSAppsTests", dependencies: ["iOSApps"], path: "Tests/iOSAppsTests")
    ]
)
