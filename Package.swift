// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMTumblrSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TMTumblrSDK",
            targets: ["TMTumblrSDK"]),
    ],
    targets: [
        .target(
            name: "TMTumblrSDK",
            path: "Classes"
        ),
        .testTarget(
            name: "TMTumblrSDKTests",
            dependencies: ["TMTumblrSDK"],
            path: "ExampleiOS/ExampleiOSTests",
            exclude: ["info.plist"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "TMTumblrSDKSwiftTests",
            dependencies: ["TMTumblrSDK"],
            path: "ExampleiOS/ExampleiOSTestsSwift"
        )
    ]
)
