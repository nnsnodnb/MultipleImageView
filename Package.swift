// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MultipleImageView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MultipleImageView",
            targets: ["MultipleImageView"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MultipleImageView",
            dependencies: [],
            path: "MultipleImageView")
    ]
)
