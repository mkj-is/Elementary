// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Elementary",
    products: [
        .library(
            name: "Elementary",
            targets: ["Elementary"])
    ],
    targets: [
        .target(
            name: "Elementary"),
        .testTarget(
            name: "ElementaryTests",
            dependencies: ["Elementary"])
    ]
)
