// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "email",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(name: "Email", targets: ["Email"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.66.1"),
    ],
    targets: [
        .target(name: "Email", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "EmailTests", dependencies: [
            .target(name: "Email"),
            .product(name: "XCTVapor", package: "vapor")
        ]),
    ]
)
