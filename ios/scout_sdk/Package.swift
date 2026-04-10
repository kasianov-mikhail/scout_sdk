// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "scout_sdk",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .library(name: "scout-sdk", targets: ["scout_sdk"])
    ],
    dependencies: [
        .package(url: "https://github.com/kasianov-mikhail/scout.git", from: "3.1.0"),
    ],
    targets: [
        .target(
            name: "scout_sdk",
            dependencies: [
                .product(name: "Scout", package: "scout"),
            ]
        )
    ]
)
