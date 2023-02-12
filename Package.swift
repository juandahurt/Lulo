// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Lulo",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Lulo",
            targets: ["Lulo"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Lulo",
            dependencies: []),
        .testTarget(
            name: "LuloTests",
            dependencies: ["Lulo"]),
    ]
)
