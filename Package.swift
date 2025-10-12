// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Suavis",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Suavis",
            targets: ["Suavis"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Suavis",
            dependencies: [
                .product(name: "Atomics", package: "swift-atomics")
            ],
            path: "Sources/Suavis"
        ),
        .testTarget(
            name: "SuavisTests",
            dependencies: ["Suavis"]),
    ]
)
