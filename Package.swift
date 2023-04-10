// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AmplifyUtilsNotifications",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "AmplifyUtilsNotifications",
            targets: ["AmplifyUtilsNotifications"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AmplifyUtilsNotifications",
            dependencies: []),
        .testTarget(
            name: "AmplifyUtilsNotificationsTests",
            dependencies: ["AmplifyUtilsNotifications"]),
    ]
)
