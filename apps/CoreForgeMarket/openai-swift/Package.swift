// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "openai-swift",
    products: [
        .library(name: "OpenAI", targets: ["OpenAI"])
    ],
    targets: [
        .target(name: "OpenAI", path: "Sources/OpenAI")
    ]
)
