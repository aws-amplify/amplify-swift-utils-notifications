// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AmplifUtilsNotifications",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
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
