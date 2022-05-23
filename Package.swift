// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "NetworkLayer",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]),
    ],
    targets: [
        .target(
            name: "NetworkLayer",
            dependencies: []),
    ]
)
