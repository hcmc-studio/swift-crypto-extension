// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCryptoExtension",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(
            name: "SwiftCryptoExtension",
            targets: ["SwiftCryptoExtension"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.1.0")
        ),
    ],
    targets: [
        .target(
            name: "SwiftCryptoExtension",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
    ]
)
