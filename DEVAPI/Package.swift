// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DEVAPI",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "DEVAPI",
            targets: ["DEVAPI"])
    ],
    targets: [
        .target(
            name: "DEVAPI",
            dependencies: []),
        .testTarget(
            name: "DEVAPITests",
            dependencies: ["DEVAPI"])
    ]
)
