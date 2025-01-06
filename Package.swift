// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
  
let package = Package(
    name: "BaseKit",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "BKColors", targets: ["BKColors"]),
        .library(name: "BKImages", targets: ["BKImages"]),
        .library(name: "BKAttributes", targets: ["BKAttributes"]),
        .library(name: "BKPermissions", targets: ["BKPermissions"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "BKColors"),
        .target(name: "BKPermissions"),
        .target(name: "BKImages", dependencies: ["BKColors"]),
        .target(name: "BKAttributes", dependencies: ["BKImages", "BKColors"]),
    ]
)
